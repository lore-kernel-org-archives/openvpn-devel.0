Date: Mon, 8 Mar 2021 11:53:09 +0100 (CET)
Message-Id: <202103081053.128Ar9Y6018297@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210305141352.21847-1-arne@...1227...>
References: <20210305141352.21847-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Prefer TLS libraries TLS PRF
 function, fix OpenVPN in FIPS mode
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

After some discussion on IRC today, it turns out that I was holding
my test rig wrong.  As in: breakage occurs in the combination of
"mbed TLS 2.25.0, TLS, TCP and --dev tap", but it does not actually 
matter whether this patch is applied or not - 2.5.1 breaks as well.  

Arne's test found the commit in mbedTLS between 2.24 and 2.25 that 
introduces the breakage (360e2c41d8211e43), but this does not really
explain anything - but it's fairly clear "not something broken in
our code", or at least "not recently".

As discussed on IRC, I have fixed what whitespace uncrustify complained
about ("if<blank>(", function return types on the preceding line, #endif
with comment)

This all said, I now do actually understand what the patch does (and it
looks good) and I think I have all versions of old/new mbedtls and
old/new openssl covered, client and server.  All pass, except for 
mbedtls 2.25.0 + tcp + tap.

Your patch has been applied to the master branch.

commit 06f6cf3ff850f2930bf4a864ae9898407e94ffb9
Author: Arne Schwabe
Date:   Fri Mar 5 15:13:52 2021 +0100

     Prefer TLS libraries TLS PRF function, fix OpenVPN in FIPS mode

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210305141352.21847-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21612.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


