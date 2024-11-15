Message-ID: <944a791b-5a5d-a15f-3ce3-4b7e472a188c@...2108...>
Date: Fri, 15 Nov 2024 14:27:49 +0100
MIME-Version: 1.0
References: <CAC8x_z0gMKW1b33J3HGL-9pQnXgpf9O6pRu+M2=xP03JyJMm6g@...278...>
 <ZzZvEOjQ4PQ3gF-2@...1296...>
 <CAC8x_z3reFPQWPNuoB-GjqkQtEgcgGapHWKUVt=OXvMoW6NCFg@...278...>
 <CAC8x_z1jmeg+4DvahuMhc5AsEg=-Kkq9G6m08LtPQWX0FkDgPw@...278...>
From: David Sommerseth <dazo+openvpn@...2108...>
Content-Language: en-GB
In-Reply-To: <CAC8x_z1jmeg+4DvahuMhc5AsEg=-Kkq9G6m08LtPQWX0FkDgPw@...278...>
Subject: Re: [Openvpn-devel] Subject: OpenVPN Client Vulnerability - TLS Key
 Negotiation Timeout Leading to DoS (Black Box Pentest)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?16DXqteZINep15jXqNef?= <nsh531@...277...>, Openvpn-devel@lists.sourceforge.net
Cc: SECURITY@...515...

On 15/11/2024 13:37, נתי שטרן wrote:
> 
> 
> ‫בתאריך יום ו׳, 15 בנוב׳ 2024 ב-14:31 מאת נתי שטרן <‪nsh531@...277... 
> <mailto:nsh531@...277...>‬‏>:‬
> 
>     Is it cve/vdp?
>     Whether it is or not, I would appreciate it if you could guide me on
>     how to develop a patch that will close the aforementioned loophole

If it is a CVE, that's something we decide when we see the issue 
reported.  What you brought to the security list recently is not a CVE.

How to develop a patch?  You need to clone the source code using git, 
fix the issue how you think it should be fixed and then submit a patch 
using the git tools.  Then the patch is reviewed and discussed, and if 
it is approved (ACKed) it is applied to the appropriate git branches in 
the official git repositories.

More details here: 
<https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation>


-- 
kind regards,

David Sommerseth
OpenVPN Inc



