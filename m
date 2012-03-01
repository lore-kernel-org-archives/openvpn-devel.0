Date: Thu, 1 Mar 2012 14:00:47 +0100
From: =?iso-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Message-ID: <237575008.20120301140047@...449...>
In-Reply-To: <4F4F6C84.3070503@...1114...>
References: <4F4CE4FE.3010009@...515...> <3440230.bBsdCSzEj1@...1526...>
	<1375292789.20120229123817@...449...> <7855235.EvfmKnZP6h@...1526...>
	<CAP+U6t+ZUA3UpYfKms0Qr=-Cn1M-GP1EJtGybG0+j+O2xnfv7g@...278...>
	<1957833067.20120229194040@...449...>
	<4F4E7BEE.50700@...1114...>
	<1656594721.20120229203737@...449...>
	<4F4F6675.1090306@...1114...>
	<38614505.20120301131554@...449...>
	<4F4F6C84.3070503@...1114...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
Reply-To: =?iso-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello David,

Thx for explantion of script usage.

DS> Well, I can agree to that.  But this is all open source.  No matter how
DS> much restrictions you put into the openvpn product, the user can download
DS> the source, add the features missing, and reconnect with a modified
DS> OpenVPN version.

ACK, if he has the complete configuration and all secrets.

But in enterprise scenario the user has only a company configured
machine and his own username/password or smartcard. For example
tls-key could be unkown to user.
The user can't boot his own machine, install patched openvpn and
connect to vpn server because one secret is missing.

That's the reason why I think openvpn shouldn't be started as an user
and config must controlled from enterprise.

Cisco introduced a stupid encryption of key material in .vcf.
The user should be allowed to setup the tunnel on this own.
User can take http://newgre.net/passwordrevealer and Shrewsoft Client
to connect. All enforcements are gone (push redirect-gateway for
example).

DS> be code which is not easily available, so the client can't fake this
DS> operation as well.

ACK

DS> Bottom line is, you can't fully control the client environment.

You can't control the client from a VPN tool. You have to control the
client in enterprise directly. Group policies, software restriction
policies, good ACLs, etc.

DS> What you can do on the client side, is to avoid a third party (think
DS> virus/malware) to figure out that openvpn is installed, and tweak the
DS> config to run code which was not supposed to be run with higher
DS> privileges.

Virus runs with user privileges, config is only modifiable with admin
privileges. No problem. Virus can establish VPN connection, same like
the user.

DS>  So the client should try to lock down things locally, to
DS> reduce the impact from local exploits.

Not the openvpn client but the complete machine.

DS> There's no real way you can make the server enforce restrictions on the client.

Full ACK

greetings
Carsten




