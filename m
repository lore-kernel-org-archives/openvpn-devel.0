Message-Id: <201709201059.v8KAxOc2014584@...2300...>
From: Casper.Dik@...2299...
In-Reply-To: <80a5d2fc-819c-76d7-f51d-2a2d476bf31a@...1937...> 
References: <201708291322.v7TDMcY3029206@...2300...>
 <20170829190353.GX70062@...1296...>
 <201708300839.v7U8dklY019715@...2300...>
 <ed6292e5-2877-7ca8-bf7b-80fe8e7da72e@...1227...>
 <201708310611.v7V6Bj1f010862@...2300...>
 <80a5d2fc-819c-76d7-f51d-2a2d476bf31a@...1937...> 
Mime-Version: 1.0
Date: Wed, 20 Sep 2017 12:59:24 +0200
Subject: Re: [Openvpn-devel] Solaris 11: t_lpback.sh coredump on AES-GCM
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: Alexander Pyhalov <alp@...1937...>
Cc: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>Hello.
>
>Spent a day debugging this issue on OpenIndiana.
>If anyone steps on this once again...
>It seems the issue was caused OI/Solaris OpenSSL specific patches, in 
>particular by 
>https://github.com/OpenIndiana/oi-userland/blob/oi/hipster/components/library/openssl/openssl-1.0.
2/patches/036-evp_leak.patch 
>. It was fixed in solaris-userland in this commit - 
>https://github.com/oracle/solaris-userland/commit/05790938481cdceaedb2a9aee700bcec6fca7e34 
>  .


Yes I had bug 26336744 filed for this and figured out what was causing it; 
as a result it has been fixed in Solaris userland (in both branches).

The fix was also delivered in Solaris 11.3 SRU 24 which was released 
somewhere in the last week.

# pkg list -H entire openssl
entire                                            0.5.11-0.175.3.24.0.4.0    i--
library/security/openssl                          1.0.2.11-0.175.3.24.0.4.0  i--

(the weird numbers are historic and should be changed to a more easily 
understandable numbers in 11.4)

Casper


