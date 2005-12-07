From: Tim Niemueller <gmane@...513...>
Message-ID: <4396AC31.7000002@...513...>
References: <dn52v4$51h$1@...165...> <Pine.LNX.4.64.0512070752400.27495@...210...>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.64.0512070752400.27495@...210...>
Subject: [Openvpn-devel] Re: Disable --redirect-gateway
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
Date: Wed Dec  7 01:39:02 2005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Mathias Sundman wrote:
> On Tue, 6 Dec 2005, Tim Niemueller wrote:
> 
> 
> I can't see anywhere in the change-log that this would now be the
> default, and I can't see why it should be either. Have you verifyed that
> it really is the default in 2.1?
> 

In the man page of the OpenVPN 2.1 beta 7 package it says (in the
description of the --redirect-gateway argument):

Using the def1 flag is highly recommended, and is currently planned to
become the default by OpenVPN 2.1.

A user has reported this for the behaviour that the packaged version in
Fedora Extras Devel shows; see
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=175047

This makes me think that is is not only planned but already the default
in the beta. I didn't look at the source, yet.

	Tim

-- 
    Tim Niemueller <tim@...513...>      www.niemueller.de
=================================================================
 Imagination is more important than knowledge. (Albert Einstein)


