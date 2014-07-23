Message-ID: <53CF5656.3000105@...68...>
Date: Wed, 23 Jul 2014 08:29:42 +0200
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <OF80C424FD.27405071-ONC1257C07.004692C7-C1257C07.004BC7CB@...1923...>	<OFF4D01B5D.C068F160-ONC1257D1D.0055C3F1-C1257D1D.005A2BE1@...1846...>	<9998AE72-2992-4D02-8E27-BE9A55BDBDF6@...1286...>	<20140722193436.GI1118@...1296...>
	<OF0A6F87B6.7643FAD4-ONC1257D1E.00208574-C1257D1E.0022B4AF@...1846...>
In-Reply-To: <OF0A6F87B6.7643FAD4-ONC1257D1E.00208574-C1257D1E.0022B4AF@...1846...>
Subject: Re: [Openvpn-devel] Openvpn 2.3.2: "Could not create temporary
 file" ....Too many open files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Am 23.07.2014 08:19, schrieb arno.odermatt@...1845...:
> Dear both,
> 
> thank you for your reply.
> Yes, we are using the "--client-connect" and according to 2.3 OpenVPN
> manual (see section below) it does create files by writing to "file
> named by $1."
> 
> Gert, we are sure, there was not a problem with the resources (eg.: max
> open files, max filed descriptors, etc.) on the system.
> What else can I do about it?

Do you impose lower per-process or per-group limits?

Did you exhaust the number of inodes on the /var partition (although you
should normally get ENOSPC in that situation).

Other than that, the proposal is to check lsof output with a few
connections there and also a few gone already, in order to see if there
are leaks.


