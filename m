References: <1528020718-12721-1-git-send-email-steffan@...1856...>
 <1528020718-12721-3-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <d027e4da-1c53-bcb3-9fed-dc249b710015@...1227...>
Date: Sun, 3 Jun 2018 20:06:13 +0200
MIME-Version: 1.0
In-Reply-To: <1528020718-12721-3-git-send-email-steffan@...1856...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 3/3] Print a --verb 1 warning when a
 connection uses compression
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
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

Am 03.06.18 um 12:11 schrieb Steffan Karger:
> +                msg(M_INFO, "WARNING: Compression enabled, might be insure. "
> +                    "See --compress in the man page.");


With my client maintainer hat on, this message is too vague. People will
ask why compression is insure, because the warning message does not
really tell much. I think the warning message should be more verbose
something like


WARNING: Compression enabled, Compression has been used in the past to
break encryption and for strengthening security, it is recommended to
disable it. For more details see --compress in the man page

Arne


