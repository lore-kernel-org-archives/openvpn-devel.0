Date: Mon, 15 Sep 2008 11:48:12 +0200
From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20080915094812.GB7136@...33...>
References: <48CDC8F9.5080609@...41...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <48CDC8F9.5080609@...41...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc11 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Yonan <jim@...41...>
Cc: Openvpn-devel@lists.sourceforge.net

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, 14 Sep 2008, James Yonan wrote:

> This release fixes a serious (though not security-related) bug in the 
> SSL/TLS negotiation over UDP that can cause SSL/TLS handshake failures. 
>   The bug was introduced in 2.1_rc9.
> 
> All users of OpenVPN 2.1_rc9 and rc10 are urged to upgrade.
> 
> Change log:
> 
> 2008.09.14 -- Version 2.1_rc11
> 
> * Fixed a bug that can cause SSL/TLS negotiations in UDP mode
>    to fail if UDP packets are dropped.
> 
> James

Hi James,

we missed patching the Makefile.am part in _rc9 when updating the tests;
the new t_cltsrv-down.sh script doesn't become part of the tarball. The
Makefile.am patch below fixes it. Please apply.

Thanks & best regards

-- 
Matthias Andree

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="patch-Makefile.am"

Index: Makefile.am
===================================================================
--- Makefile.am	(Revision 3331)
+++ Makefile.am	(Arbeitskopie)
@@ -64,7 +64,8 @@
 dist_noinst_SCRIPTS = \
 	$(TESTS) \
 	doclean \
-	domake-win
+	domake-win \
+	t_cltsrv-down.sh
 
 dist_noinst_DATA = \
 	openvpn.spec \

--fUYQa+Pmc3FrFX/N--

