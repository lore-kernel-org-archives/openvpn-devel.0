Message-ID: <e22e11f96343e7507b1270a30b37225d.squirrel@...2260...>
In-Reply-To: <f4e7f2e8-5310-a982-ffb3-67c0f0abb3ec@...2080...>
References: <ee5a8207241568cedcccc4f7f2ea5bc8.squirrel@...2257...>
	<b6bac00d6d7260eea944814b0c995806.squirrel@...2257...>
	<53a21cf3f4e04fcf5d6b9798e04be3ce.squirrel@...2257...>
	<20170404064534.GC93896@...1296...>
	<6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
	<20170405065745.GI93896@...1296...>
	<c923cbd7-6876-dfcf-513c-f8bbba21f421@...1435...>
	<f4e7f2e8-5310-a982-ffb3-67c0f0abb3ec@...2080...>
Date: Wed, 5 Apr 2017 14:36:15 +0200
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
 component to --reneg-sec intervals
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

> On 05/04/17 09:31, Steffan Karger wrote:
>> Hi,
>>
>> On 05-04-17 08:57, Gert Doering wrote:
>>> On Wed, Apr 05, 2017 at 06:34:34AM +0200, Simon Matter wrote:
>>>> I've attached v2 now which works without any config change:
>>> [..]
>>>> I prefer this version as it allows everybody to profit from it without
>>>> touching any config files.
>>>
>>> I can see the reasoning, but 25% feels a bit on the high side :-) - so
>>> let the ratholing begin what the number should be.
>>>
>>> Steffan, any views from the crypto side of things?
>>
>> Not really.  I think the feature makes sense, and I like that this will
>> only *substract* from the set time (so not exceed any set limits).
>>
>> (And I agree that 25% feels on the high side - my gut says somewhere
>> around 10%, but I have no analysis to show why that would be better.
>> I'll leave picking that number to you.)
>
> The default is 60 minutes.  With 25% that means a time window of 15
> minutes, so reneg-sec will occur between 45-60 minutes.
>
> I see this can be too much for some sites, and perhaps too little on
> sites which have many users.   With 10%, the reneg-window is reduced to
> 54-60 minutes.  For larger sites, this is most likely too small of a
> window - though far better than everyone at "exactly" 60 minutes.
>
> But I am also wondering if this randomness should only occur on the
> first renegotiation.
>
> If you have a 6 minutes time window and 100 connected clients, there is
> a big chance that at some point the randomness will cause a similar
> congestion again, as multiple clients to have the same delay.  With 25%
> that chance is lower, but the chance increases again with more clients.
>
> So what if this randomness instead only occurs on the _first_
> negotiation and then respect the --regneg-sec setting?  Then clients
> will somewhat spread out and then keep a certain predictable
> renegotiation load.  And if using 17%, you get a time window of roughly
> 10-11 minutes where renegotiation happens.  With 100 clients, that means
> roughly (with a theoretical, ideal and even spread) 10 clients per
> minute.  Which is more reasonable.  With 200 clients, it is still
> getting crowded but not too bad.
>
> But all that said ... I think it would be wise to have an optional
> argument to --reneg-sec (in addition to the 'sec' argument we have
> today) which can be used to further open or close this time window.
> Larger sites will most likely want a larger time window than smaller ones.
>
> Btw ... is --reneg-sec pushable?  (Too lazy to check the code, man page
> says "no").  If not, it would probably be a good idea to enable that.

As I understand it client and server have 60 min. by default. Whatever is
configured, the smaller value wins. That means, bad clients can set their
reneg-sec to very low values and trash the server on the other end. From
the server side this looks more or less like a DDOS.

In our environment we have set reneg-sec=3D0 on all clients because we want
the server to have control over it. That's fine because we have only
trusted clients. Making it pushable could be a solution to overwrite bad
settings in clients. A more radical solution was to just remove the option
on the client side.

Regards,
Simon


