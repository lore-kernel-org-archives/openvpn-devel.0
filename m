References: <bd464d61-d16e-4a9b-de38-f96891e65368@...2525...>
 <7b72d228-e801-b490-86d5-6e763919d317@...1227...>
 <cb0d489a-b2e2-bab8-b774-bdfb6e20376d@...2525...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <54a17061-3fdd-5097-a59c-56a55d43c447@...1227...>
Date: Sat, 24 Aug 2019 18:04:21 +0200
MIME-Version: 1.0
In-Reply-To: <cb0d489a-b2e2-bab8-b774-bdfb6e20376d@...2525...>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Juliusz Sosinowicz <juliusz@...2525...>, openvpn-devel@lists.sourceforge.net
Cc: Todd Ouska <todd@...2525...>, Sean Parkinson <sean@...2525...>

Hey,

thanks for taking your time to answer.

I want to give you an honest opionion of mine to merging WolfSSL in
OpenVPN. Please note, that this is my personal opinion and not to be
confused to be an official OpenVPN community project or OpenVPN Inc
position.

For every patch we have to decide if it worth accepting it and if the
maintainance of the code is worthless and if the code itself is
acceptable. Adding a third crypto library duplicates an already existing
feature. So there needs to a very compelling reason for us to add this
large feature.

We have not seen any involvement from your companay in the OpenVPN
project so far. So accepting this patch and then later finding out that
we have high maintainance cost for it, is something I really would like
to avoid.

OpenVPN runs on small deployment but nothing that is really embedded.
And almost all these already have mbed TLS or OpenSSL in place. In the
main system that OpenVPN targets which are typical Unix systems or
Windows, I have not really seen much use of WolfSSL either or seen a
single email/issue/ticket requesting support for it, so from my personal
impression there seem to be not much need for WolfSSL.

In summary, I personally cannot really find a good reason to incoperate
WolfSSL currently into OpenVPN.

For the future of the patch. I would recommend that you keep maintaining
that patch out of tree. We incorporate the fixes changes in the rest of
OpenVPN to make this a more viable option. If your involvement in
OpenVPN is high enough that I and others do feel that accepting the
patch is a burden anymore, it can be merged in the future.


> thank you for the feedback. To answer your questions:
> 
> 
> - Why WolfSSL in OpenVPN instead of mbed or OpenSSL
> wolfSSL can be compiled to use very few resources in a wide array of
> embedded environments.

That seem to be also the stated goal for mbed TLS.

> wolfSSL is FIPS ready - that is it has all the code available to be FIPS
> 140 validated on a platform.
> - What features does WolfSSL offer in OpenVPN that mbed/OpenSSL don't have
> wolfSSL has a large customer base and some of them would like to use
> OpenVPN with wolfSSL.

I personally do not care for FIPS. Also that feel more like marketing
for WolfSSL rather to what actually is an improvement to OepnVPN.


> - What is missing with WolfSSL?
> wolfSSL doesn’t support some older, weaker algorithms like Blowfish.
> wolfSSL also lacks support for CryptoAPI and exporting of keying material.

Otherwise it is a complete drop in replacement for OpenSSL?

> - What are your future plans in terms of involvement in OpenVPN
> development and maintaince?
> Our plans are to help support and maintain the wolfSSL component of any
> project, including OpenVPN, that decides to incorporate our technology.

When I asked here I meant more involvement in the OpenVPN project. I.e.
helping reviewing patches that are cyrpto related. Looking into bug
fixing etc. Fox It that did the mbed TLS port of OpenVPN did and is
still involved in these kind of things.

Furthermore the commitment here is bit too vague for me even for the
maintaince of the WolfSSL support. It sounds like a PR phrase. "WolfSSL
component" for all that I know could just mean WolfSSL itself.

> Regarding our OpenSSL compatibility layer: we do have a compatibility
> layer for OpenSSL but it still lacks many features. In addition, using
> wolfSSL directly without an additional layer allows for better
> efficiency and performance.

This very vague.

Arne

