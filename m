From: Denis Vlasenko <vda@...216...>
Subject: Re: [Openvpn-devel] Re: Interface with GUI agent
References: <40E18559.8020407@...244...> <Pine.LNX.4.60.0407082214170.6520@...210...> <40F129D4.7070909@...83...>
In-Reply-To: <40F129D4.7070909@...83...>
MIME-Version: 1.0
Message-Id: <200407111827.07179.vda@...216...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun Jul 11 08:28:09 2004
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Jan Kiszka <jan.kiszka@...83...>, Mathias Sundman <mathias@...209...>
Cc: openvpn-devel@lists.sourceforge.net

On Sunday 11 July 2004 14:51, Jan Kiszka wrote:
> Mathias Sundman wrote:
> > ...
> > One more thing to consider... Should we consider a system running this
> > service manager an open system where all locally logged on users is
> > allowed to fully manage openvpn connections, which includes:
> >
> > * Start/Stop openvpn processes
>
> As a first step, I think we should allow all users to access this
> service. Later on, one may consider some authorisation mechanism to
> access specific configurations. This could be some additional parameter
> in a config file or some meta config file for the wrapping service.

Just use ssh. Those who know username/password of special user
able to control openvpn could log in via ssh and do it.
--
vda


