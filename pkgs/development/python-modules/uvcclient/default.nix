{ lib, buildPythonPackage, fetchFromGitHub, pythonOlder, pynose, mock }:

buildPythonPackage rec {
  pname = "uvcclient";
  version = "0.11.0";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "kk7ds";
    repo = pname;
    rev = "58e7a53815482b7778481f81cde95f53a60bb6f6";
    sha256 = "0k8aswrk1n08w6pi6dg0zdzsmk23cafihkrss9ywg3i85w7q43x2";
  };

  postPatch = ''
    substituteInPlace tests/test_camera.py \
      --replace-fail "assertEquals" "assertEqual"
  '';

  nativeCheckInputs = [
    pynose
    mock
  ];

  checkPhase = ''
    nosetests
  '';

  meta = with lib; {
    description = "Client for Ubiquiti's Unifi Camera NVR";
    homepage = "https://github.com/kk7ds/uvcclient";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ hexa ];
  };
}
