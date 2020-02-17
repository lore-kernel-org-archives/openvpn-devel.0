MIME-Version: 1.0
References: <20200217144339.3273-1-arne@...1227...>
 <20200217144339.3273-6-arne@...1227...>
In-Reply-To: <20200217144339.3273-6-arne@...1227...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 17 Feb 2020 17:26:04 +0200
Message-ID: <CAGyAFMVrC0TWn4S2eG1qdWyZO9C2SPPfivT83Z19AA-ASU_==A@...278...>
Subject: Re: [Openvpn-devel] [PATCH v4 5/5] Normalise ncp-ciphers option and
 restrict it to 127 bytes
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

Stared at the code, built and tested on MSVC and Ubuntu 18.
Cipher "chacha20-POLY1305" correctly translated into "CHACHA20-POLY1305".
Also (updated) unit tests passed.

Acked-by: Lev Stipakov <lstipakov@...277...>

