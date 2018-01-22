MIME-Version: 1.0
In-Reply-To: <20180122162121.GV69387@...1296...>
References: <CAKuzo_jF_fHfcEPUXeo6WKWQ4tw7T72-cexEUda=USGd9Ref7g@...278...>
 <e09e95cd-a6d1-e1c0-9c05-738362207278@...2080...>
 <98ce7083179e0a097b35953a9ef3879c.squirrel@...2257...>
 <91ffd543-3f5a-e08d-ac89-379770b46b96@...2080...>
 <1f480b84-a0f8-a0a0-7bf7-0081e44d1c06@...1435...>
 <20180122162121.GV69387@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 22 Jan 2018 11:40:56 -0500
Message-ID: <CAKuzo_i4aXPcKqfGiFjWtTesov5EP=a7dRCtqwLUThWZ=UYObg@...278...>
Subject: Re: [Openvpn-devel] On testing with openssl 0.9.8
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
To: Gert Doering <gert@...1296...>
Cc: Steffan Karger <steffan.karger@...1435...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Mon, Jan 22, 2018 at 11:21 AM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Mon, Jan 22, 2018 at 05:05:35PM +0100, Steffan Karger wrote:
>> > So if we don't have really strong arguments keeping support for
>> > this old version, we should carefully consider our options.
>>
>> We already removed support for < 1.0.1 in the master branch.  Maybe
>> just make sure we can get 2.5 out, and move forward that way :)
>
> So, what's missing for 2.5?  :-)
>
> I can see "tls crypt v2", "refactor route.c and tun.c", "netlink"
> here - what else?

How did we get to 2.5 from openssl-0.9.8? Anyway, I'm happy to see
that 0.9.8 is not widely used and slacking while testing patches will
be excused..

OK, the thread yielded to the more exciting 2.5 discussion :)

Selva

