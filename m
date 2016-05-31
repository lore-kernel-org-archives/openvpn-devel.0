References: <1464668569-6480-1-git-send-email-selva.nair@...277...>
	<61d8d41f-4c77-5235-a202-642983d494a3@...1227...>
	<CAKuzo_gyWfFnOe72CKkyPfAHAfN5uF8jWqp2jCosdZkJBYwoBw@...278...>
	<574DAECE.8000202@...2080...>
	<20160531155607.GA53051@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <574DB6E7.8030400@...2080...>
Date: Tue, 31 May 2016 18:08:07 +0200
MIME-Version: 1.0
In-Reply-To: <20160531155607.GA53051@...1296...>
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

On 31/05/16 17:56, Gert Doering wrote:
> Hi,
> 
> On Tue, May 31, 2016 at 05:33:34PM +0200, David Sommerseth wrote:
>> I think a fixed list of 64 slots is more than good enough in this case.
>> I even considered suggesting 32 slots, but 64 is reasonable as a maximum
>> currently.  An average openvpn config is probably roughly 10-15 lines
>> all in all (not considering inline files). If someone pushes more than
>> 50-60 options, then something more funky is probably going on as well.
> 
> This is not to be *pushed* but local sanity control for pushed stuff :-)
> 
> ValdikSS is pushing well over 1000 routes, so "60" is really not much
> in that regard...

Clumsy wording on my side.  Yeah, I understand it is a local filter.
And that one filter may filter out far more than just a single pushed
option.

My point was more that if more than 50-60 filters are needed, then you
have a bigger challenge than just these filters.


-- 
kind regards,

David Sommerseth

