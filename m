Date: Wed, 11 Sep 2013 10:58:45 +0200
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20130911085845.GA6506@...1330...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Subject: [Openvpn-devel] Patch to make uppercasing x509-username-field
	optional
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: Andris Kalnozols <andris@...1839...>

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Andris Kalnozols from HP sent me the attached patch in order to make
upper casing the --x509-username-field optional so that fields called
something like "emailAddress" could be used.

He proposed using square brackets [1] in order to specify a field name that
should not be capitalized. Please consider its inclusion, or an
alternative to address this matter.

Thanks,

Alberto

[1]=20
x509-username-field foo -> will look for a field named FOO
x509-username-field [emailAddress] -> will look for emailAddress

--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
agi@(inittab.org|debian.org)| en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 5347 CBD8 3E30 A9EB 4D7D  4BF2 009B 3375 6B9A AA55

--r5Pyd7+fXNt84Ff3
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="x509-username-field-casing.patch"

--- openvpn-2.3.2/src/openvpn/options.c.orig    2013-09-09 01:41:26.000000000 -0700
+++ openvpn-2.3.2/src/openvpn/options.c 2013-09-09 01:21:30.000000000 -0700
@@ -6750,8 +6750,23 @@
     {
       char *s = p[1];
       VERIFY_PERMISSION (OPT_P_GENERAL);
-      if( strncmp ("ext:",s,4) != 0 )
-        while ((*s = toupper(*s)) != '\0') s++; /* Uppercase if necessary */
+      if (strncmp ("ext:", s, 4) != 0)
+       {
+         /* By default, the alphabetic characters of an alternate
+          * username field are uppercased.  Accommodate special
+          * requirements, however, by leaving the field name
+          * unchanged if it is enclosed by square brackets.
+          */
+         size_t s_len;
+         s_len = strlen (s);
+         if (*s == '[' && *(s + s_len - 1) == ']')
+           {
+             memmove (s, s + 1, s_len - 2);    /* strip the quoting brackets */
+             *(s + s_len - 2) = '\0';
+           }
+         else
+           while ((*s = toupper (*s)) != '\0') s++;
+       }
       options->x509_username_field = p[1];
     }
 #endif /* ENABLE_X509ALTUSERNAME */

--r5Pyd7+fXNt84Ff3--

