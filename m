Date: Thu, 9 Jun 2022 15:58:10 +0200 (CEST)
Message-Id: <202206091358.259DwAUF017972@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220603095219.637361-1-arne@...1227...>
References: <20220603095219.637361-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allow running a default
 configuration with TLS libraries without BF-CBC
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

Acked-by: Gert Doering <gert@...1296...>

Stared at code, and tested with a 2.5+ossl3.0.x build - without the
patch, it would fail before even trying to connect to the server
(unless --providers legacy default is set):

2022-06-09 12:00:50 library versions: OpenSSL 3.0.3 3 May 2022, LZO 2.10
2022-06-09 12:00:50 Cipher BF-CBC not supported
2022-06-09 12:00:50 Exiting due to fatal error

With the patch, it connects fine, negotiates AES-256-GCM, and passes 
all t_client tests (to "master" servers") without having to resort to
"--providers legacy".

Connecting to a legacy server (2.3 or 2.4/2.5 with --disable-ncp, or
restricting ciphers to BF-CBC for whatever other reasons) will try to 
fallback to BF-CBC, and fail - unsurprisingly, but fixable with 
--providers legacy.


NOTE: uncrustify complained to me that "options.c" got modified and
was not uncrustify clean before -> so I included these whitespace
changes (not many, and only trivial stuff) in this commit.


Your patch has been applied to the release/2.5 branch.

commit 15bf49797130917d85837abd3e8c1fb0e9b528b7
Author: Arne Schwabe
Date:   Fri Jun 3 11:52:19 2022 +0200

     Allow running a default configuration with TLS libraries without BF-CBC

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220603095219.637361-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24456.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


