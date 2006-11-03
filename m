Message-ID: <9e0cf0bf0611022324l4c7f6339jd21033a8aeb28f7c@...278...>
Date: Fri, 3 Nov 2006 09:24:43 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <454A6CE1.5070002@...41...>
MIME-Version: 1.0
References: <451FBC52.70900@...41...>
	<451FC16A.2010906@...795...>
	<45480C70.5080502@...41...>
	<200611011516.31060.alon.barlev@...277...>
	<454A6CE1.5070002@...41...>
Subject: Re: [Openvpn-devel] OpenVPN Roadmap
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: James Yonan <jim@...41...>
Cc: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

On 11/3/06, James Yonan <jim@...41...> wrote:
> > 1. Handling privilege dropping correctly, so that client can drop
> > privileges before connect.
> >
>
> Actually there is flexibility here -- the client can drop privileges
> earlier by config file option, but it generally doesn't until after the
> connection is established so that it can accept pushed routes from the
> server -- we could fix this by using a split privilege model, but then
> you have to deal with the extra complexity.

I don't like split privilege model, since the split part always runs
as privileged user... We don't need that, we can make use of sudo
command to do all the stuff we need to do, and via script interface
which is much simper. This is true that we have a problem with this
feature in Windows environment, but I don't think we should support
every feature in  Windows as well, Windows machine will work as now
without changing user id.

> > 3. Allow the management to perform private key operations, so that
> > pre-authenticated keys can be used out of an agent, or different
> > sources, such as KDE, smartcards or any other storage. (This makes 2
> > obsolete).

> I think it's great if you are volunteering to do this.   It's an

Sure!

> interesting idea, to move CryptoAPI and PKCS#11 code out of OpenVPN
> executable into a library that would be used by the GUI.  My only
> concern is that I don't want to make it much more difficult to write an
> OpenVPN GUI.  So I'm thinking that this would be an optional capability
> that GUIs could choose to implement.

True. I will leave the file based (RSA/PKCS#12) authentication inside OpenVPN.
So that GUI that don't wish to use external devices will be able to,
but we should encourage people to use the library also for key based
files.
Please set release target for this feature.

Best Regards,
Alon Bar-Lev.

