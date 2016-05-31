References: <1464668569-6480-1-git-send-email-selva.nair@...277...>
	<61d8d41f-4c77-5235-a202-642983d494a3@...1227...>
	<CAKuzo_gyWfFnOe72CKkyPfAHAfN5uF8jWqp2jCosdZkJBYwoBw@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <574DAECE.8000202@...2080...>
Date: Tue, 31 May 2016 17:33:34 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gyWfFnOe72CKkyPfAHAfN5uF8jWqp2jCosdZkJBYwoBw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add an option to filter options
 received from server
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>, Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 31/05/16 17:24, Selva Nair wrote:
> Hi,
>
> On Tue, May 31, 2016 at 4:37 AM, Arne Schwabe <arne@...1227...
> <mailto:arne@...1227...>> wrote:
>
>     Am 31.05.16 um 06:22 schrieb Selva Nair:
>     > +#define PULL_FILTER_LIST_SIZE 64
>     We already have dymanic lists, used for ignore-unknown-options and
>     --route, any reason not to use them here?
>
>
> I just thought 64 is good enough and kept it simple like the
> connection_list.
>
> Will consider making it dynamic if we go for a v2.

I think a fixed list of 64 slots is more than good enough in this case.
I even considered suggesting 32 slots, but 64 is reasonable as a maximum
currently.  An average openvpn config is probably roughly 10-15 lines
all in all (not considering inline files). If someone pushes more than
50-60 options, then something more funky is probably going on as well.

*If* this limit gets too annoying, then I we can reconsider using a
dynamic list.


--
kind regards,

David Sommerseth




