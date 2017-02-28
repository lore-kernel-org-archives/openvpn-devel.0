References: <003bd3ed-9a64-3e77-cd06-2212b82a6165@...515...>
	<6a8f8780-a49c-9d1f-30ac-d3b804e9476b@...1435...>
	<5cab0f4b-c40e-c11d-25e7-dc276d18317c@...515...>
	<d86d9946-dfa1-785b-5fe5-fe44acadda18@...1435...>
	<e0a6e693-96ee-3c3d-f17f-d62c45676b5a@...515...>
	<4cfe9376-5bc1-51da-4082-9837b232a40f@...1856...>
	<1c3fb5b3-39c8-1c4b-c531-9cb2480a2382@...515...>
	<13666431-ed44-1ac1-2fef-fe295b33cc97@...1856...>
	<419e734c-8879-8bdd-e6cf-94dd16de86cc@...515...>
	<7fe7759e-88b6-4b9f-9026-c76323fe72d9@...2080...>
From: James Yonan <james@...515...>
Message-ID: <ed02f62b-00f4-d02f-4fb6-ccff761dcb8d@...515...>
Date: Mon, 27 Feb 2017 22:09:40 -0700
MIME-Version: 1.0
In-Reply-To: <7fe7759e-88b6-4b9f-9026-c76323fe72d9@...2080...>
Subject: Re: [Openvpn-devel] Should we use mbedTLS certificate profiles?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 27/02/2017 18:18, David Sommerseth wrote:

> On 27/02/17 23:06, James Yonan wrote:
>> On 25/02/2017 08:40, Steffan Karger wrote:
> [...snip...]
>>> I'd say so.  Something like:
>>>
>>> legacy: RSA 1024+, SHA1+, all curves
>>> default: RSA 2048+, SHA2+, all curves
>>> suiteb: no RSA, SHA256/SHA384, P-256/P-384
>>>
>>> As long as we kick anything that's deprecated out of 'default', that
>>> should probably suffice.
>> That sounds good, but I'm thinking that we should probably name
>> "default" something else, such as "standard", so there's no confusion
>> between the cert profile name, and which cert profile is chosen by
>> default which may vary according to app preferences/settings.
>>
>> For example in mobile clients, we would probably need an app-level
>> setting to indicate whether "legacy" or "standard" should be the
>> default, but that would be confusing if "default" was actually a profile
>> name.
> There's a narrow edge here before it becomes bike-shedding; I do try to
> avoid that ... but what about:  legacy, preferred and suiteb ?
>
> "Standard" just sounds a bit too static to me, that is not something
> which changes much.  So in 5 or 10 years from now, "standard" may just
> as much be "legacy".  Hence my suggestion for "preferred"; this is what
> we prefer now.  "legacy" is what we used and can even include what we
> preferred earlier.

I'm okay with legacy, preferred and suiteb.

James


