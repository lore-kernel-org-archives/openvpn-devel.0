Message-ID: <7bb03bbe8955dacd3a3130f64724024f.squirrel@...2257...>
In-Reply-To: <20170531092817.GH97029@...1296...>
References: <1496177444-18373-1-git-send-email-steffan@...1856...>
	<29f51139-a525-fd92-0fe1-195d308d2924@...2080...>
	<20170531070258.GC97029@...1296...>
	<ae93b702-4edd-6772-0f1d-ac9629589ee8@...2080...>
	<20170531092817.GH97029@...1296...>
Date: Wed, 31 May 2017 15:51:13 +0200
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH release/2.4] configure.ac: fix building
 against static openssl
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

> Hi,
>
> On Wed, May 31, 2017 at 11:14:33AM +0200, David Sommerseth wrote:
>> On 31/05/17 09:02, Gert Doering wrote:
>> > Hi,
>> >
>> > On Wed, May 31, 2017 at 02:31:40AM +0200, David Sommerseth wrote:
>> >> If we really do care for supporting 0.9.8, in release/2.4 - I can
>> give
>> >> this an ACK.  Otherwise, I think it might be better to backport
>> >> 039a89c331e9b7998d804 + 79ea67f77ca3afe91222f.
>> >
>> > You are the one that objects most violently if we break users'
>> expectations
>>
>> Yes and no.  In regards to end users, I am very careful.  In regards to
>> package maintainers, I am less weary as they won't distribute failing
>> builds to end users.  This change hits package building, not the end
>> user.
>
> Well, this is a somewhat simplistic world view, with "package builders"
> and "package installers".
>
> People are stuck on older enterprise distributions, for whatever reasons,
> but want a newer openvpn version - so they get the source bundle, and
> compile.  Which is a perfectly fine deployment model - and we should not
> break things in 2.4.3 that worked just fine in 2.4.2 for them (unless
> there is a strong reason, like "we have a vulnerability here that we
> cannot fix unless we abandon an older API").

I strongly support your view, Gert. I really hope we do not see such
breakage in minor stable releases.

Regards,
Simon


