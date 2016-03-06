MIME-Version: 1.0
In-Reply-To: <1456993146-63968-5-git-send-email-james@...515...>
References: <1456993146-63968-1-git-send-email-james@...515...>
	<1456993146-63968-5-git-send-email-james@...515...>
From: Steffan Karger <steffan@...1856...>
Date: Sun, 6 Mar 2016 20:40:35 +0100
Message-ID: <CAA1AbxLoCowGA7B=VF6hjhVy6ta91CVGBfgCkT_YBQh0ZM1VEA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 05/10] Extended x509-track for OpenSSL
 to report SHA1 fingerprint.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: James Yonan <james@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Thu, Mar 3, 2016 at 9:19 AM, James Yonan <james@...515...> wrote:
> +               char *sha1_fingerprint = format_hex_ex(x509->sha1_hash, SHA_DIGEST_LENGTH, 0, 1 | FHE_CAPS, ":", &gc);

This line could use some wrapping.  Perhaps Gert can fix this when applying?

Otherwise, ACK.

-Steffan

