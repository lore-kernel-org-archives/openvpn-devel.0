From: Mathias Sundman <mathias@...454...>
Subject: Re: [Openvpn-devel] Inline certs/keys?
In-Reply-To: <Pine.NEB.4.61.0606011124370.29663@...641...>
Message-ID: <Pine.LNX.4.64.0606011502410.25275@...210...>
References: <Pine.NEB.4.61.0606011124370.29663@...641...>
MIME-Version: 1.0
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
Date: Thu Jun  1 06:10:04 2006
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: Stephen Borrill <netbsd@...640...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, 1 Jun 2006, Stephen Borrill wrote:

> Could the configuration file format be extended to allow inclusion of 
> relevant certs and keys in-line?

Already added in the 2.1-beta series. Snip from the changelog:

* Allow ca, cert, key, and dh files to be specified
   inline via XML-like syntax without needing to
   reference an explicit file.
   For example:
   <ca>
 	data here...
   </ca>


