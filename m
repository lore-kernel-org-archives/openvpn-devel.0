References: <bd464d61-d16e-4a9b-de38-f96891e65368@...2525...>
 <7b72d228-e801-b490-86d5-6e763919d317@...1227...>
 <cb0d489a-b2e2-bab8-b774-bdfb6e20376d@...2525...>
 <54a17061-3fdd-5097-a59c-56a55d43c447@...1227...>
 <20190824194037.GA1349@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <a7cdf61e-c0ea-c12f-bd3a-0cacc9d68333@...2080...>
Date: Mon, 26 Aug 2019 18:53:33 +0200
MIME-Version: 1.0
In-Reply-To: <20190824194037.GA1349@...1296...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Adding support for wolfSSL backend
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Todd Ouska <todd@...2525...>, Sean Parkinson <sean@...2525...>, Juliusz Sosinowicz <juliusz@...2525...>
Cc: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 24/08/2019 21:40, Gert Doering wrote:
> Hi,
> 
> On Sat, Aug 24, 2019 at 06:04:21PM +0200, Arne Schwabe wrote:
>> I want to give you an honest opionion of mine to merging WolfSSL in
>> OpenVPN. Please note, that this is my personal opinion and not to be
>> confused to be an official OpenVPN community project or OpenVPN Inc
>> position.
> 
> Arne summarized things quite well.  New and large additions need to
> balance "what *our* users want/need", "what the core team finds 
> interesting enough to spend time on" and "how expensive in terms of 
> maintainer lifetime will it be to maintain that stuff".
> 
> Since we're currently short on contributors that can review crypto
> related code changes, and we do not have anyone in the team today
> that can review WolfSSL interface code at all, this isn't likely 
> going to happen in the near future.

I have to say both Arne and Gert do have some really valid points.

But there is a lot to learn from Fox-ITs involvement.  We *are* open to new
contributors, who can be resources on various segments of OpenVPN.  And we
have few resources who really understands the depths of cryptology; we lean a
lot on Steffan and Arne currently.  But the initial PolarSSL support got
acceptance because they more or less promised to help OpenVPN in the future on
the crypto side.

What I'm saying, if you in WolfSSL are willing to help out, be available and
help out responding to crypto related questions and patches on this -devel
mailing list, be present in the community IRC channels, etc ... this would
make it far easier to accept another crypto backend.  And this is basically
what Fox-IT has done via Steffan (and earlier Adrian).

This is also how we got IPv6 support in OpenVPN too; Gert had patches several
years ago he maintained, he grew trust and with that he got more challenges
and is now a co-maintainer of the OpenVPN community project.  Lev got involved
as well in a similar way, with features F-Secure Freedome needed at that time.
 And you can find that a lot of the active people here get their changes
included, because they're active on a regular bases.

It doesn't mean they need to be active every day, but that they keep in touch
at least every now and then on mailing lists or IRC and join the hackathons
from time to time.

So getting a trust that you're going to be available also after WolfSSL
support is added is kind of the key point; to help maintaining both the
WolfSSL implementation but also helping out on a regular basis, especially on
the crypto side.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


