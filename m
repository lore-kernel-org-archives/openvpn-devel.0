From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] OpenVPN multi instancing
Message-ID: <20040302101450.GA7745@...33...>
References: <200402291538.45014.cd@...154...> <twig.1078170122.8125@...41...>
Mime-Version: 1.0
In-Reply-To: <twig.1078170122.8125@...41...>
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
Date: Tue Mar  2 02:20:03 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Mon, 01 Mar 2004, James Yonan wrote:

> Christian Daniel <cd@...154...> said:
> 
> > Hello everybody!
> > 
> > For a student research project I'm trying to add multi instance capability to 
> > OpenVPN. The basic idea is to rip the main openvpn()-function apart, put all 
> > variables in a struct and then have only one select()-call for all open 
> > tunnels at once.
> 
> It's already been done :)
> 
> See the BETA20 branch in the CVS.

Is there a document that mentions the development tags so the daring
know what to check out? Or a mailing list I should subscribe to?

May I suggest to post the pointer to the document or add one to
openvpn.sourceforge.net?

Thanks. (It's incredible how much room for improvement OpenVPN still
has, while having been stable and production-ready for so long already.)

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95

