References: <CAKuzo_hdohByd29VTjx=Q7bM9zZCqp85W=u=nJwJ3-HLqN1zSg@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56371F6C.7070101@...515...>
Date: Mon, 2 Nov 2015 10:31:40 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hdohByd29VTjx=Q7bM9zZCqp85W=u=nJwJ3-HLqN1zSg@...278...>
Subject: Re: [Openvpn-devel] Windows: stopping openvpn using nssm
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hi,
>
> When nssm is used to start openvpn, "nssm stop service-name" appears to
> terminate the process not so gracefully. Especially, the log doesn't
> show the usual "SIGTERM received, sending exit-notify" (for example) nor
> does the the management interface get the state change message saying
> EXITING.  (Tested on version 2.3.6)
>
> I thought adding --service to the command line may cure this, but it
> doesn't. Any suggestions on how to teach openvpn to process termination
> by nssm as a SIGTERM, or make nssm send a SIGTERM?

Hi,

Based on NSSM documentation forcibly killing the daemon is the last resort:

<http://nssm.cc/usage#shutdown>

Best regards,

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

