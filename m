From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Again: Feature implementation: Connection refusal
 based upon CN
In-Reply-To: <4161A650.1020706@...289...>
Message-ID: <Pine.LNX.4.58.0410042230440.16439@...269...>
References: <4161A650.1020706@...289...>
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
Date: Mon Oct  4 22:16:57 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Vlada Macek <tuttle@...288...>
Cc: openvpn-devel@lists.sourceforge.net

Vlada,

I think the idea for the patch is good, i.e. using the client-config-dir
as a kind of authenticator of common names.

I do have a concern though on your implementation.  You are conducting the
allow/deny test in multi_connection_established(). The problem is that
this function runs too late in the client instance initialization sequence
to be able to securely deny authentication.

There is a window of time between when the SSL/TLS state goes to S_ACTIVE
and when multi_connection_established is executed that you essentially
have a trusted session, and a malicious client could potentially exploit
that fact.  I think it would be better to put the test somewhere in ssl.c,
so that on failure, you can prevent the SSL/TLS state from advancing to
S_ACTIVE.  That is the idea behind verify_callback() and --tls-auth.

James


> Hello,
> 
> I'm writing again on the topic of my post sent several hours ago to the
> openvpn-users list. The post proposed the --ccd-exclusive option.
> 
> Since then I tried to setup chrooted openvpn server with the ccd
> directory in the jail as well as the tls-verify script which was
> checking the content of the ccd directory (see my previous post for the
> reason). Even when I hosted shell, tun device, some so's from /lib in
> the jail, openvpn was still unable to run my tls-verify script.
> 
> Nevertheless I didn't like the size of the jail directory after all. I
> decided to write the proposed feature on my own. So the 2.0-beta11
> source files, manual page was modified and an option helptexts was
> added. (I have to state, the work on such source text is a delight.)
> There was not clear to me, whether I kill the current instance
> gracefully, it needs some other eye to check it.
> 
> The implementation is tested. IMO it properly reacts on the removal and
> appearance of the CN-file in the client-config-directory.
> 
> I'm attaching the patch, because I hope someone else could find my
> contribution useful. Now I'm able to push the fixed IP addresses by the
> certificate CN as well as refuse non approved CN's from the single data
> source (ccd). My chroot jail now contains just a couple of non binary
> bytes. I'm happy for now. :-)
> 
> May I ask James to consider adding some form of this piece to the source
> of his wonderful program?
> 
> Vlada
> 
> 

