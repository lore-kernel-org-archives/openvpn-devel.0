From: Alberto Gonzalez Iniesta <agi@...5...>
Message-ID: <20040527163029.GA2138@...30...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
Subject: [Openvpn-devel] verify-cn script
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu May 27 11:16:12 2004
To: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hiya,

I was taking a look at the scripts that come with with OpenVPN tarball
and wondered why 'verify-cn' is written in Perl. Specially when the rest
of the scripts are written in shell/bash. Any particular reason?
I mean, running it in shell should be, if not a bit faster, more light
on things OpenVPN depends on (i.e. not requiring Perl).

I haven't tested this one (see attach) thoroughly but it seems to do
the job.

Thoughts?


-- 
Alberto Gonzalez Iniesta   | BOFH excuse #5:
agi@(agi.as|debian.org)    | static from plastic slide rules
Encrypted mail preferred   | 

Key fingerprint = 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

--azLHFNyN32YCQGCU
Content-Type: application/x-sh
Content-Disposition: attachment; filename="verify-cn.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A=0A# Verify X509 Common Name=0A#=0A# Return 0 if cn matches the=
 common name component of X509_NAME_oneline,=0A# 1 otherwise.=0A#=0A# For e=
xample in openvpn, you could use the option:=0A#  --tls-verify "./verify-cn=
 Test-Client"=0A=0A[ $# -eq 3 ] || { echo usage: verify-cn cn certificate_d=
epth X509_NAME_oneline ; exit 255 ; }=0A=0A# $2 -> certificate_depth=0Aif [=
 $2 -eq 0 ] ; then=0A	# $3 -> X509_NAME_oneline=0A	NAME=3D`echo $3 | /usr/b=
in/cut -c5-`=0A	FIELD=3D`echo $3 | /usr/bin/cut -c-4`=0A	# $1 -> cn we are =
looking for=0A	if [ "$FIELD" =3D "/CN=3D" -a "$NAME" =3D "$1" ] ; then=0A		=
exit 0=0A	fi=0A	exit 1=0Afi=0A=0Aexit 0=0A
--azLHFNyN32YCQGCU--

