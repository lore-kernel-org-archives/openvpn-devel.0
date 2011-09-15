From: Eric Crist <ecrist@...1286...>
Date: Thu, 15 Sep 2011 09:22:09 -0500
Message-Id: <D37A00C0-4EDA-4ACD-A872-7A6D876C5905@...1286...>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Subject: [Openvpn-devel] tun.c patch breaks compile on FreeBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: James Yonan <james@...515...>
Cc: openvpn-devel@lists.sourceforge.net

James,

It would appear a patch you committed breaks compile on FreeBSD.  Part of t=
his removes r.defined, which is looked for during compile on FreeBSD, and s=
pecifically stops things during compile of tun.c.  The commit in question i=
s 7fb0e07ec3f7c5f65 visible here:

http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopenvpn/openvpn-testi=
ng.git;a=3Dcommitdiff;h=3D7fb0e07ec3f7c5f6514523085dbe02ea6b8933e2

The configure line used is as follows:

$ ./configure --with-lzo-lib=3D/usr/local/lib --with-lzo-headers=3D/usr/loc=
al/include --disable-depr-random-resolv --enable-password-save --disable-pk=
cs11 --prefix=3D/usr/local --mandir=3D/usr/local/man --infodir=3D/usr/local=
/info/ --build=3Damd64-portbld-freebsd9.0

Feel free to talk to me here or, easier for me, on IRC if you'd like to tes=
t.

Eric Crist
