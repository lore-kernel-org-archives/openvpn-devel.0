MIME-Version: 1.0
In-Reply-To: <CAKuzo_jPThhvXTJAtzhqVUVOLPW1VGu6h2jQhVsHicY8P2WRqA@...278...>
References: <CAKuzo_jPThhvXTJAtzhqVUVOLPW1VGu6h2jQhVsHicY8P2WRqA@...278...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Thu, 30 Nov 2017 20:41:12 -0500
Message-ID: <CAEsd45T7i0CLzEFmLE5xhe451YZRZHMBn1dEWEtF=xtND=ejGQ@...278...>
Subject: Re: [Openvpn-devel] Follow up on sending messages to the GUI
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
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Thanks, Selva,

On Wed, Nov 29, 2017 at 9:03 PM, Selva Nair <selva.nair@...277...> wrote:
>
> I have made a draft implementation of this feature that was discussed in a previous thread. A test executable (GUI only) is in this pre-release:
>
> https://github.com/selvanair/openvpn-gui/releases/tag/v11-echo-msg
<SNIP>
>
> Also see some technical notes included in the above link.

The technical notes say

     In case of "echo msg text" the previous text, if any, is appended
with a new line. An empty text in this case will just add a new line.

Is that the same as

     In case of "echo msg text" the previous text, if any, is appended
with text and then a new line. An empty text in this case will just
add a new line.

? (That is, the new line comes after the text, not after the previous text.)

Best regards,

Jon

