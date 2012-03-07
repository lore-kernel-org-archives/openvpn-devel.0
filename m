MIME-Version: 1.0
Date: Wed, 07 Mar 2012 11:04:48 +0100
From: michael-dev <michael-dev@...1528...>
Message-ID: <e68a5a6c7eea0d84c83facae9151acab@...1528...>
Subject: Re: [Openvpn-devel] OpenVPN Management Interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On Wed, 07 Mar 2012 09:00:04 +1300, Jason Haar wrote:
> Your comments on rogue servers is certainly worth discussing too.
> What can a rogue openvpn server push back to a client? Routes 
> obviously - but
> other than screwing the client, is there any new risk?

if you expect the server to be rouge, openvpn client has to be careful 
with input data validation - for example when running an ifconfig, you 
could try some injection into the run commands. (Or within the up/down 
scripts.)
If you don't expect the server to be rouge, SSL on client side would 
prevent most attacks.

As far as I can see, push/pull is already limited for security reasons.

Regards,
  M. Braun


