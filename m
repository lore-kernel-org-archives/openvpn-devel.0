References: <bd464d61-d16e-4a9b-de38-f96891e65368@...2525...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <7b72d228-e801-b490-86d5-6e763919d317@...1227...>
Date: Fri, 16 Aug 2019 17:30:42 +0200
MIME-Version: 1.0
In-Reply-To: <bd464d61-d16e-4a9b-de38-f96891e65368@...2525...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH] Adding support for wolfSSL backend
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Juliusz Sosinowicz <juliusz@...2525...>, openvpn-devel@lists.sourceforge.net
Cc: Todd Ouska <todd@...2525...>, Sean Parkinson <sean@...2525...>

Am 16.08.19 um 16:14 schrieb Juliusz Sosinowicz:
> This patch adds the option to use wolfSSL as the ssl backend. To build
> this patch:
> 

That is great and it is also a very big patch. I skimmed only through
the patch.


+#ifdef ENABLE_CRYPTO_WOLFSSL
+    o->ciphername = "AES-256-CBC";
+#else
     o->ciphername = "BF-CBC";
+#endif

Such silent changes that OpenVPN behaves different, is something we
would like to avoid. Better to error out in this case than to behave
diffently.

Overall the WolfSSL feels to be a bit similar to OpenSSL. Is there any
compatibility you are aiming at?

Also it would be nice to have a summary for people on the OpenVPN
perspective

- Why WolfSSL in OpenVPN instead of mbed or OpenSSL
- What features does WolfSSL offer in OpenVPN that mbed/OpenSSL don't have
- What is missing with WolfSSL?

That should also good to have in the patch like README.mbedtls.

And one of the important question is:

What are your future plans in terms of involvement in OpenVPN
development and maintaince? I think since you are first time contributer
and this a big patch, that is something resonable to ask.

Arne

