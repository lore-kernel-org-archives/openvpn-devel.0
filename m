Message-ID: <f60dbf91-c2f8-495b-ba14-967e70629d1b@...1227...>
Date: Thu, 22 May 2025 13:14:10 +0200
MIME-Version: 1.0
References: <1e8ccfd451cbf9e6d090bd6a6886e366.squirrel@...2890...>
 <20250507074438.1326755-1-walter.openvpn@...2889...>
 <eedcf175305a088df0eb7ec146dbe441.squirrel@...2890...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <eedcf175305a088df0eb7ec146dbe441.squirrel@...2890...>
Subject: Re: [Openvpn-devel] [PATCH] multi.c: Allow floating to a new IP
 right after connection setup
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
To: Walter Doekes <walter.openvpn@...2889...>, openvpn-devel@lists.sourceforge.net


Am 22.05.2025 um 09:09 schrieb Walter Doekes:
> Dear mailing list and Arne,
>
> I saw in the IRC meeting notes that 2.7 is about to be branched.
>
> I don't mean to push, but I personally think this bug is important enough
> to get looked at and fixed, preferably before 2.7.0 is made.
>
> Is this new patch good enough? Should I put it in Gerrit? Are there any
> questions about the functionality?
>
> I realise that I did not explain _why_ b364711486 breaks things. I'm also
> curious, but I think the author of that patch, or someone else more
> intimate with the codebase, can more easily explain. Regardless there is a
> bug in 2.6.x right now, and I'd would like it if a fix is upstreamed; be
> it my fix, or someone elses.

The thing is that I do not really understand your scenario and how it 
exactly breaks for you to the extend that I cannot reproduce the issue.

You are saying that the client switches the IP address after connect. But that is just a regular float from the perspective of the VPN server. I still do not understand where the other connection that is already on that IP/port is coming from. It is also not an older connection as it is not a fully established connection either.

In summary I am not able to either reproduce or understand what is happning in your scenario. And I do not want to apply a patch that I don't understand.

Arne


