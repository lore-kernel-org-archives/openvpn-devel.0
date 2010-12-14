Date: Tue, 14 Dec 2010 16:45:24 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <AANLkTi=GLcQr-S8B8GT3nHmsPm7uiQRSRTr1zTytiE1u@...278...>
	(from vineet.kumar@...277... on Tue Dec 14 16:22:53 2010)
Message-Id: <1292366724.16783.0@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Can *plugin* kill specific ovpn tunnel?...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Vineet Kumar <vineet.kumar@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On 12/14/2010 04:22:53 PM, Vineet Kumar wrote:
> Sorry pl. explain the "intermediary" part. Is that supposed to solve
> the single telnet server accepting multiple *concurrent* client
> sessions?

Yes.  The multiple concurrent client sessions talk to a single=20
telnet server via an intermediary.  The intermediary serializes
the requests made by the multiple concurrent sessions and feeds
the resulting stream to the single telnet session.

A simpleminded way to do this might be to dump the requests
into files in a directory that's monitored by incron, which
then feeds the commands to, say, socat or nc (netcat).
(Incron is a nice intermediary because it isolates the
requests -- they can be monitored for correctness etc.)
I've no idea if this is the right approach for your application.



Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


