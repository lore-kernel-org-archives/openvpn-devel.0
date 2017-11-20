References: <20170505214624.11675-1-davids@...515...>
 <CAKuzo_gaQexyhX9RJTZkoqpTsPFL=cjqX+p90KEdMBiU7jckjg@...278...>
Reply-To: openvpn-devel@lists.sourceforge.net
From: David Sommerseth <openvpn@...2080...>
Message-ID: <d25449a1-25ea-f451-b192-ca60d7c2ed48@...2080...>
Date: Mon, 20 Nov 2017 21:10:36 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gaQexyhX9RJTZkoqpTsPFL=cjqX+p90KEdMBiU7jckjg@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 1/2] plugin: Export base64 encode and
 decode functions
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
To: Selva <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 19/11/17 22:21, Selva wrote:
> Hi David,
> 
> On Fri, May 5, 2017 at 5:46 PM, David Sommerseth <davids@...515...
> <mailto:davids@...515...>> wrote:
> 
>     This patch builds on the "Export secure_memzero() to plug-ins" patch and
>     adds export of openvpn_base64_encode() and openvpn_base64_decode()
> 
>     This also ships with a very simple plug-in which demonstrates how to use
>     the new exported functions.
> 
>  
> This has remained in a limbo mainly because of me pushing for a correction
> to the plugin_v3 API. Obviously that hasn't got any traction.
> 
> If you separate this into two patches: (i) export base64 (ii) usage sample
> we can get (i) merged right away and move on to patches that would benefit
> from it.

Hi Selva,

This has gone in-and-out of my TODO list for quite some time, and I've
even had some help from Antonio double checking the plugin_v3 API
corrections.  I've just been side-tracked on more urgent matters.

We actually ended up concluding that we can fix the API without making
things worse.  Which is the most important detail here.

I'll try to get some time fixing this and respond a bit quicker.



-- 
kind regards,

David Sommerseth
OpenVPN, Inc


