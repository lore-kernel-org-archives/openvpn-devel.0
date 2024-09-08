Date: Sun, 8 Sep 2024 22:41:21 +0200 (CEST)
Message-Id: <202409082041.488KfLeN094702@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240906103734.36633-1-frank@...2641...>
References: <20240906103734.36633-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Interpret --key and --cert
 option argument as URI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

I have not tested this beyond basic "do t_client and server tests
still work" - no suitable OpenSSL provider infrastructure here, and
stalling the patch until I find time to set up more tests is not
helping anyone, given that Frank has done quite heavy testing already.

I've stared a bit at the code and things seem reasonable :-) - and
come with a unit test! (well, in the next patch)

I'm a bit curious about the new ui_reader() function - it says
"wrapper for pem_password_callback()" but the actuall call there
seems hidden in "SSL_CTX_get_default_passwd_cb()" - is my interpretation
correct?  But anyway, there might be an undefined variable lurking
in

        /* If pkcs#11 Use custom prompt similar to pkcs11-helper */
        if (strstr(prompt, "PKCS#11"))
        {
            struct user_pass up;
            get_user_pass(&up, NULL, "PKCS#11 token", ...

"up" is not initialized, and the first thing get_user_pass_cr() does
is look at "if (!up->defined)".  So if I'm not misreading this, a
followup patch to initialize "up" would be good.  At this point it
might be nice to add a comment explaining how the wrapping of
"pem_password_callback()" works ;-)


Your patch has been applied to the master branch.

commit 3512e8d3ada4fa7d04925a89fd9f3669655c7887 (master)
Author: Selva Nair
Date:   Fri Sep 6 12:37:34 2024 +0200

     Interpret --key and --cert option argument as URI

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240906103734.36633-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29075.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


