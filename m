MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Sat, 7 Nov 2015 00:35:12 -0500
Message-ID: <CAKuzo_hsHus7dgLMi8D=SzQn4f+2GNQJjx8HACvD3xmsD=Ux5w@...278...>
Subject: [Openvpn-devel] Adding a ctrl-C handler in windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

I plan to add a control-C handler in win32.c. The handler will simply
map it to SIGTERM. Is there any particular reason why control-C is not
currently handled?

We need this functionality to use nssm properly. When
openvpn is started by nssm, the service has no good ways of
gracefully terminating the process. "nssm stop service-name" can send
control-C but that is not handled by openvpn. So the default handler
catches the signal and just kills the process -- thus the MI or the logs
get no reports of the exit, no exit-notify to the remote are
generated etc..

Hope I'm not missing some obvious ways to correctly terminate the
process from nssm.

Thanks,

Selva

