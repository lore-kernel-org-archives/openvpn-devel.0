Resent-Message-ID: <20051229083141.GA3285@...522...>
Resent-To: openvpn-devel@lists.sourceforge.net
From: Ondra Medek <ondrejm@...522...>
Message-ID: <20051228134659.GA5600@...522...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Reading PIN for PKCS#11 from file
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
Date: Thu Dec 29 00:37:15 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

I like PKCS#11 support in new OpenVPN 2.1beta7. But I need to start client
using eToken without user interaction, i.e. to read the user PIN from a
file. A have already made a very simple hack to the pkcs11.c - the name of
the file storing the PIN is hardcoded, see end of the post. I like to have
this feature in the future releases of the OpenVPN. If you want, I can try
to implemented it better. My ideas are

1) either to use existing --auth-user-pass or --askpass options,
2) or to make a new option, i.e. --pkcs11-pin-file

Cheers
           Ondrej Medek

--- pkcs11.c.orig       2005-11-02 19:02:52.000000000 +0100
+++ pkcs11.c    2005-12-27 10:29:09.830280656 +0100
@@ -99,7 +99,7 @@
                 
        token_pass.defined = false;
        token_pass.nocache = true;
-       get_user_pass (&token_pass, NULL, szPrompt, GET_USER_PASS_MANAGEMENT|GET_USER_PASS_PASSWORD_ONLY);
+       get_user_pass (&token_pass, "pin", szPrompt, GET_USER_PASS_MANAGEMENT|GET_USER_PASS_PASSWORD_ONLY);
        strncpynt (szPIN, token_pass.password, nMaxPIN);
        purge_user_pass (&token_pass, true);

