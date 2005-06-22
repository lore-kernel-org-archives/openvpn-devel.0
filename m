From: Simon Perreault <nomis80@...401...>
Subject: Re: [Openvpn-devel] Why must PAM library be dlopened?
References: <200506141234.50171.nomis80@...401...> <200506221459.16684.nomis80@...401...> <200506221515.36785.nomis80@...401...>
In-Reply-To: <200506221515.36785.nomis80@...401...>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_erbuC8QDetAyDCO"
Message-Id: <200506221524.14029.nomis80@...401...>
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
Date: Wed Jun 22 12:25:12 2005
To: openvpn-devel@lists.sourceforge.net

--Boundary-00=_erbuC8QDetAyDCO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 22 June 2005 15:15, Simon Perreault wrote:
> That's a bug that should be reported
> to SUSE.

...and here is the patch that should be submitted to them. I won't do so, I 
don't want to help a distro which has given me so much trouble. (Much more 
than only openvpn-related trouble.)

--Boundary-00=_erbuC8QDetAyDCO
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="pam-modules-9.3-link-with-pam.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pam-modules-9.3-link-with-pam.diff"

--- pam-modules-9.3/pam_unix2-1.26/src/Makefile.am.orig	2005-06-22 15:21:18.000000000 -0400
+++ pam-modules-9.3/pam_unix2-1.26/src/Makefile.am	2005-06-22 15:19:02.000000000 -0400
@@ -24,7 +24,8 @@
 pam_PROGRAMS = pam_unix2.so
 
 pam_unix2_so_LDFLAGS = -Wl,-soname,pam_unix2.so \
-	-Wl,--version-script=$(srcdir)/pam_unix2.map
+	-Wl,--version-script=$(srcdir)/pam_unix2.map \
+	$(LIBPAM)
 
 pam_unix2_so_SOURCES = passwd_nss.c unix_acct.c get_options.c \
 	unix_passwd.c yppasswd_xdr.c passwd_nisplus.c support.c \

--Boundary-00=_erbuC8QDetAyDCO--

