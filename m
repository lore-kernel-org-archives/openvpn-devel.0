Message-ID: <4d2efb18-77e7-47a3-b5c4-b7f14d2f5f2a@...1227...>
Date: Mon, 16 Mar 2026 13:30:19 +0100
MIME-Version: 1.0
References: <20260315184337.1541272-1-luca.boccassi@...277...>
 <20260315230620.1594780-1-luca.boccassi@...277...>
 <20260315230620.1594780-2-luca.boccassi@...277...>
 <b54e0eae-8fe2-420e-ba24-4d73ca50086d@...1227...>
 <CAMw=ZnQy+i0debrWv2ya=xy12_h1EmrRVfiuKEK9-aWZ6GJRoQ@...278...>
 <150f9ffe-bf48-43dd-86aa-b69961de1f99@...1227...>
 <CAMw=ZnQxvpy2Xx2rFHZCJprzx=SG_SC-i1O80noVRT7_BAOKJQ@...278...>
 <af798d10-e06c-46f7-a45d-378f76b9bafa@...1227...>
 <CAMw=ZnR7QBEo1tueV_mKnq=RJGNOtVfWoapmYiAy1WteX4rBoA@...278...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAMw=ZnR7QBEo1tueV_mKnq=RJGNOtVfWoapmYiAy1WteX4rBoA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/3] Increase TLS_CHANNEL_BUF_SIZE
 from 2048 to 8192
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Luca Boccassi <luca.boccassi@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Am 16.03.26 um 13:17 schrieb Luca Boccassi:
> 
> Oh it's even worse than that, I assure you :-) It's an internal
> reimplementation, it does not use the open source server sadly. But it
> is the openvpn protocol, and it works once the allowance for a large
> password is made.
> 
> I am trying to get the standard network-manager + openvpn setup to
> work with it, to at least be spared from having to use the absolutely
> horrendous proprietary client that comes with it.
> In case you are curious, the network-manager-openvpn side is here:
> https://gitlab.gnome.org/bluca/NetworkManager-openvpn/-/commits/entra_auth?ref_type=heads
> With these changes, it works nicely.
> 
> Of course I'm more than happy to get the client changes here in a form
> that is acceptable to you, but would really appreciate guidance, as
> you can tell I am completely new to this project. The only limitation
> I have is that I can't change how the server works (I wish...), but on
> the client side I am open to anything that works.

Yeah the problem is that they made changes that are not really 
acceptable in general for our project. You basically would need a 
special azvpn mode in OpenVPN that is only activated via a configuration 
option or similar and that would also have a lot of code overhead to 
enable/disable this mode in various parts of OpenVPN. And we need some 
strong reason to include such a hack mode that we need to maintain then 
forever in our code base.

I am afraid that for now using a specially patched version is probably 
easier/better to do.

Arne

