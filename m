MIME-Version: 1.0
In-Reply-To: <56371F6C.7070101@...515...>
References: <CAKuzo_hdohByd29VTjx=Q7bM9zZCqp85W=u=nJwJ3-HLqN1zSg@...278...>
	<56371F6C.7070101@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 2 Nov 2015 09:02:12 -0500
Message-ID: <CAKuzo_iZGo=5W=wjYa5WbSptjUX=nAdTDXYyM+=ox7sEQK03DA@...278...>
Subject: Re: [Openvpn-devel] Windows: stopping openvpn using nssm
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Mon, Nov 2, 2015 at 3:31 AM, Samuli Sepp=C3=A4nen <samuli@...515...> wro=
te:
>>
>> I thought adding --service to the command line may cure this, but it
>> doesn't. Any suggestions on how to teach openvpn to process termination
>> by nssm as a SIGTERM, or make nssm send a SIGTERM?
>
>
> Hi,
>
> Based on NSSM documentation forcibly killing the daemon is the last resor=
t:
>
> <http://nssm.cc/usage#shutdown>


Yes, as per the docs, it sends control-C, WM_CLOSE, WM_QUIT and then
forcibly terminate. So when you execute  "nssm stop service-name", it
must be sending control-C. However, openvpn terminates writing nothing
to the log and without the EXIT message to the management interface.
Nor does it send exit-notify to the remote.

Looking at the code, it appears SIGTERM and SIGINT are not handled on
windows (does windows even have those signals?) so nssm sending
control-C may not be work with openvpn.

So the question is how to modify openvpn so that it will terminate on
control-C on windows?

Thanks,

Selva

