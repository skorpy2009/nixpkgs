{ lib
, buildPythonPackage
, fetchFromGitHub
, isPy27
, pytestCheckHook
, scipy
, numpy
, scikit-learn
, pandas
, matplotlib
, joblib
}:

buildPythonPackage rec {
  pname = "mlxtend";
  version = "0.19.0";
  disabled = isPy27;

  src = fetchFromGitHub {
    owner = "rasbt";
    repo = pname;
    rev = version;
    sha256 = "0qawzlzv4zf612n9n03fxnz6gxmzschq0ykh9dgv70l33ihmjbaw";
  };

  checkInputs = [ pytestCheckHook ];
  # image tests download files over the network
  pytestFlagsArray = [ "-sv" "--ignore=mlxtend/image" ];
  # Fixed in master, but failing in release version
  # see: https://github.com/rasbt/mlxtend/pull/721
  disabledTests = [ "test_variance_explained_ratio" ];

  propagatedBuildInputs = [
    scipy
    numpy
    scikit-learn
    pandas
    matplotlib
    joblib
  ];

  meta = with lib; {
    description = "A library of Python tools and extensions for data science";
    homepage = "https://github.com/rasbt/mlxtend";
    license= licenses.bsd3;
    maintainers = with maintainers; [ evax ];
    platforms = platforms.unix;
    # incompatible with nixpkgs scikit-learn version
    broken = true;
  };
}
