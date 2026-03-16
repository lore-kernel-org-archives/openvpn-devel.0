MIME-Version: 1.0
References: <20260315184337.1541272-1-luca.boccassi@...277...>
 <20260315230620.1594780-1-luca.boccassi@...277...>
 <20260315230620.1594780-2-luca.boccassi@...277...>
 <b54e0eae-8fe2-420e-ba24-4d73ca50086d@...1227...>
 <CAMw=ZnQy+i0debrWv2ya=xy12_h1EmrRVfiuKEK9-aWZ6GJRoQ@...278...>
 <150f9ffe-bf48-43dd-86aa-b69961de1f99@...1227...>
 <CAMw=ZnQxvpy2Xx2rFHZCJprzx=SG_SC-i1O80noVRT7_BAOKJQ@...278...>
 <af798d10-e06c-46f7-a45d-378f76b9bafa@...1227...>
In-Reply-To: <af798d10-e06c-46f7-a45d-378f76b9bafa@...1227...>
From: Luca Boccassi <luca.boccassi@...277...>
Date: Mon, 16 Mar 2026 12:17:31 +0000
Message-ID: <CAMw=ZnR7QBEo1tueV_mKnq=RJGNOtVfWoapmYiAy1WteX4rBoA@...278...>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, 16 Mar 2026 at 12:11, Arne Schwabe <arne@...1227...> wrote:
> > The issue here is that the handshake fails, as the azvpn server
> > expects a full token to be received, but it gets truncated. I have no
> > control over the server, just the client. Do you have a suggestion on
> > how to solve this in a way that would be acceptable?
>
> I have no Idea what the azvpn server is and what they are doing but it
> looks like they are using some hacks that were never submitted upstream
> and also had no communication with our project. So it is not surprising
> that this does not work with the normal open source client.

Oh it's even worse than that, I assure you :-) It's an internal
reimplementation, it does not use the open source server sadly. But it
is the openvpn protocol, and it works once the allowance for a large
password is made.

I am trying to get the standard network-manager + openvpn setup to
work with it, to at least be spared from having to use the absolutely
horrendous proprietary client that comes with it.
In case you are curious, the network-manager-openvpn side is here:
https://gitlab.gnome.org/bluca/NetworkManager-openvpn/-/commits/entra_auth?ref_type=heads
With these changes, it works nicely.

Of course I'm more than happy to get the client changes here in a form
that is acceptable to you, but would really appreciate guidance, as
you can tell I am completely new to this project. The only limitation
I have is that I can't change how the server works (I wish...), but on
the client side I am open to anything that works.

Thanks for the feedback!

