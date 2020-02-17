MIME-Version: 1.0
References: <20200217115522.20068-1-arne@...1227...>
In-Reply-To: <20200217115522.20068-1-arne@...1227...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 17 Feb 2020 14:14:33 +0200
Message-ID: <CAGyAFMX4qxqG=XCC=6HFjRVpydqTPm5-hzV7VzRJWiKKd1xr_w@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3 1/5] Only announce IV_NCP=2 when we
 are willing to support these ciphers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Tested with MSVC, checked that if --ncp-ciphers options doesn't
include AES-256-GCM,
IV_NCP=2 is indeed not pushed.

Acked-by: Lev Stipakov <lstipakov@...277...>

