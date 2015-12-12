References: <CAEsd45Q9S_V137M5Db5jNT2ZFGju8XKMAUYqBeDYifjC5y=-MQ@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <566C9E48.1040806@...1227...>
Date: Sat, 12 Dec 2015 23:23:04 +0100
MIME-Version: 1.0
In-Reply-To: <CAEsd45Q9S_V137M5Db5jNT2ZFGju8XKMAUYqBeDYifjC5y=-MQ@...278...>
Subject: Re: [Openvpn-devel] Options that are "safe" for users to modify?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: "Jonathan K. Bullard" <jkbullard@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 12.12.15 um 22:47 schrieb Jonathan K. Bullard:
> Inspired by Gert, I am considering adding a new feature to Tunnelblick
> (FOSS GUI for OpenVPN on OS X) and would like your reactions. In an
> earlier thread on openvpn-users, my original more grandiose idea was
> (with good reason) NAKed. It was also suggested that openvpn-devel was
> a better place for the discussion.
> 
> The goal is to allow a non-admin to update keys and certificates
> without needing the admin authorization that is currently required by
> Tunnelblick. Changing Tunnelblick so that it runs OpenVPN as the user
> is one way of doing that, but is much more work and has broader
> consequences than what I am proposing and I'd like to avoid discussion
> of that in this thread if possible.
> 
> Tunnelblick currently "secures" OpenVPN configuration files and the
> files they reference (e.g., "targets" of --ca, --key, etc.) by making
> them writable only by root. A user can change a configuration only by
> getting admin authorization. (Some files may be readable only by root,
> too, but that's not relevant here.)


Might not really be related to this but have looked into the work that
provides the certificates and keys via the managment console? We have
even have a contrib program that gets certificates from the Mac OS X
keychain and provides them to OpenVPN.


Arne


