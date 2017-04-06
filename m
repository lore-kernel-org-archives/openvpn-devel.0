Message-ID: <ec5b45716d7fad0f492b19e6c54b82fe.squirrel@...2260...>
In-Reply-To: <20170405204236.GM93896@...1296...>
References: <6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
	<267890da-2186-dddb-d4c4-d6374da7e086@...277...>
	<049b9d27-d6a4-41cf-9742-bed02b2cc39b@...2080...>
	<18a96a72-4778-22b3-8a57-ce87d3f7060b@...2080...>
	<11253b26-cb11-8b7a-02e0-d5b1ad89e199@...277...>
	<2465b076-35e8-6144-f1b8-085ad5a016f0@...277...>
	<e09e9fbc1ce629510c439bbc06569b1a.squirrel@...2260...>
	<f6a87e19-4ac0-4ea2-69f3-2f424cbe8891@...1227...>
	<86ef0241-5144-206a-4691-6713434fdaa4@...277...>
	<20170405204236.GM93896@...1296...>
Date: Thu, 6 Apr 2017 11:45:00 +0200
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

> Hi,
>
> On Wed, Apr 05, 2017 at 07:00:54PM +0100, debbie10t wrote:
>> > Optional option does not mean that it is disabled by default. If you
>> > don't the randomness you would need to do:
>> >
>> > reneg-sec 3600 3600
>> >
>> > the optional argument also allows it to fine tune it to your needs.
>>
>> As the reason for --reneg-sec is to specify how long a key should exist,
>> I don't see any further need to make the "random window" be specifically
>> configurable .. The reneg-sec period will remain as specified (def 3600)
>> except for the first run, where --reneg-sec is started from a random
>> time between now and then.  There after returning to "normal" with full
>> randomisation of all connected clients --reneg-sec being spread over the
>> *entire* period of --reneg-sec nn and not some unnecessary window.
>
> Setups with 2FA will have to re-enter auth credentials on reneg.  Having
> OpenVPN all of a sudden default to "it could be asking 5 minutes after
> connection for the credentials again" is massive annoyance - and brings
> no real benefit anyway.
>
> It makes sense to jitter reneg-sec somewhat (like, 10%-ish), but changing
> behaviour too much is not bringing much benefit - you don't need to
> spread the reneg over the whole period anyway, as different clients
> connect and disconnect at different times anyway.  Just if all of them
> connect at the same time, the identically-timed renegs are a problem.

That's exactly what happens in the event of an OpenVPN restart on the
central server. Our router clients may all restart for updates at the same
time and our desktop clients are automatically started in the morning most
of them at the same time.

> I like Arne's and David's suggestion - the existing option "as is" will
> enable X% jitter, while a second parameter can specify a more specific
> range.  Following Arne's argument about users and percent math, it might
> indeed be better to have "min max" here ("3500 3600"), because that is
> really easy to understand and explain.

After all the discussion I prefer the simple solution. I've changed my
systems to the reduced 10% jitter and I'm wondering if it has to be made
more complicated than this? I works very well and after some hours the
renegs have spread very well. If you ask me it's perfectly fine that way
as long as the docs clearly state that a pseudo random 10% us deducted
from reneg-sec automatically to spread renegs.

Simon


