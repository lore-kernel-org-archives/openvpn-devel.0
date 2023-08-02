Message-ID: <9467eb8b-e855-7c81-b8b2-6d224d005fc2@...2108...>
Date: Wed, 2 Aug 2023 13:36:42 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230802113149.36497-1-dazo+openvpn@...2108...>
From: David Sommerseth <dazo+openvpn@...2108...>
In-Reply-To: <20230802113149.36497-1-dazo+openvpn@...2108...>
Subject: Re: [Openvpn-devel] [PATCH] ntlm: Clarify details on NTLM phase 3
 decoding
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 02/08/2023 13:31, David Sommerseth wrote:
> From: David Sommerseth <davids@...515...>
> 
> The code was very clear if we accept that the base64 decode of the

There is a "not" missing in the line above:  "The code was not very 
clear ..."

I'm fine with fixing this at commit time.


-- 
kind regards,

David Sommerseth
OpenVPN Inc



> NTLM challenge was truncated or not.  Move the related code lines
> closer to where it first used and comment what we are not concerned
> about any truncation.
> 
> If the decoded result is truncated, the NTLM server side will reject
> our new response to the challenge as it will be incorrect.  The
> buffer size fixed and known to be in a cleared state before the
> decode starts.
> 
> Resolves: TOB-OVPN-14
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>   src/openvpn/ntlm.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)


