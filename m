Message-ID: <9e0cf0bf0811160800s27626f3cmfb358fee54a34ab8@...278...>
Date: Sun, 16 Nov 2008 18:00:28 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <49204019.9080002@...1135...>
MIME-Version: 1.0
References: <48F11865.5080903@...1135...>
	<9e0cf0bf0810111522nc8062afl7e727f9d871875ec@...278...>
	<48F1AE4F.3040305@...1135...>
	<9e0cf0bf0810120211u2c8ec01ejde17ee36e5483872@...278...>
	<49204019.9080002@...1135...>
Subject: Re: [Openvpn-devel] Alternative GUI for OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Jochen Wierum <jochen@...1135...>
Cc: openvpn-devel@lists.sourceforge.net

On 11/16/08, Jochen Wierum <jochen@...1135...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
>  Hash: SHA512
>
>  Hi Alon,
>
>
>  > You should not do this.
>  > You should only use the management interface for all tasks.
>
> I know... but this brings new problems: if the configuration is invalid,
>  OpenVPN prints a warning to stderr, but not to the management interface.
>  That makes it hard do debug errors.
>

Please separate between debug and normal operation.
This will allow you to run the daemon as a service while the user will
not require special privilege.

Also, you can let the user to write his own configuration while you
just manage the connect/disconnect/authentication phases.
I think this would be best for advance users.

Alon.

