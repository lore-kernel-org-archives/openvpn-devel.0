From: Ralf =?iso-8859-1?q?L=FCbben?= <ralfluebben@...68...>
Subject: Re: [Openvpn-devel] Re: Re: Radius support (Authentification, Authorization and Accounting)
References: <200504291033.00667.ralfluebben@...68...> <d7fjlh$hrc$1@...165...> <Pine.LNX.4.58.0505301929140.8786@...41...>
In-Reply-To: <Pine.LNX.4.58.0505301929140.8786@...41...>
MIME-Version: 1.0
Message-Id: <200505310755.43517.ralfluebben@...68...>
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
Date: Mon May 30 22:59:03 2005
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hello,

Now, the accounting informations are read from the status file, which is 
generated with the interval 1s. The whole accounting stuff is done by a 
forked process. So if there are now other causes, I do not need the plugin. 


Am Dienstag, 31. Mai 2005 01:32 schrieben Sie:
> > at the momemt the radius plugin is working.
> > The plugin model is very good. It was possible to implement the plugin
> > without any problems.
>
> I know you were asking at one point for a plugin function to update
> byte-count accounting stats for each client.  Do you still need this?
>
> > I have still one question about the NAS-Port attribute. At the moment the
> > port number is increment for every user, but never decremt.
> > Will this be a problem with freeradius? Must the number be in a special
> > range, maybe for assignment?
>
> Not sure about this one.
>
> > I have still another programming question. In the plugin example for pam,
> > all functions are static functions. Which advantages has the static
> > function opposite to a "normal" function?
>
> It's not strictly necessary, but is done so that you can easily see which
> functions are externally called.

>
> James

