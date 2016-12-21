MIME-Version: 1.0
In-Reply-To: <1482353691-27088-2-git-send-email-davids@...515...>
References: <1482353691-27088-1-git-send-email-davids@...515...>
	<1482353691-27088-2-git-send-email-davids@...515...>
From: Steffan Karger <steffan@...1856...>
Date: Wed, 21 Dec 2016 22:38:15 +0100
Message-ID: <CAA1AbxLepYyLCrgNXZEsY6+i1AwsPU8TjOV5PptobenUV=eAzg@...278...>
Subject: Re: [Openvpn-devel] [PATCH release/2.3] docs: Further improve
 --reneg-bytes and SWEET32 information
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 21 December 2016 at 21:54, David Sommerseth <davids@...515...> wrote:
> +If using ciphers with cipher block sizes less than 128-bits, \-\-reneg\-bytes is
> +set to 64MB by default, unless it is explicitly disabled by setting the value to
> +0,but this is

(As in the patch for master:) missing space behind the ,.

ACK once that's fixed.

-Steffan

