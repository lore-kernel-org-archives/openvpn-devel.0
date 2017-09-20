References: <201708291322.v7TDMcY3029206@...2300...>
 <20170829190353.GX70062@...1296...>
 <201708300839.v7U8dklY019715@...2300...>
 <ed6292e5-2877-7ca8-bf7b-80fe8e7da72e@...1227...>
 <201708310611.v7V6Bj1f010862@...2300...>
From: Alexander Pyhalov <alp@...1937...>
Message-ID: <80a5d2fc-819c-76d7-f51d-2a2d476bf31a@...1937...>
Date: Wed, 20 Sep 2017 12:24:49 +0300
MIME-Version: 1.0
In-Reply-To: <201708310611.v7V6Bj1f010862@...2300...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] Solaris 11: t_lpback.sh coredump on AES-GCM
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Casper.Dik@...2299..., Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello.

Spent a day debugging this issue on OpenIndiana.
If anyone steps on this once again...
It seems the issue was caused OI/Solaris OpenSSL specific patches, in 
particular by 
https://github.com/OpenIndiana/oi-userland/blob/oi/hipster/components/library/openssl/openssl-1.0.2/patches/036-evp_leak.patch 
. It was fixed in solaris-userland in this commit - 
https://github.com/oracle/solaris-userland/commit/05790938481cdceaedb2a9aee700bcec6fca7e34 
  .
-- 
Best regards,
Alexander Pyhalov,
system administrator of Southern Federal University IT department

