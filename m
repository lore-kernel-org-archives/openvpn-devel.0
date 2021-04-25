MIME-Version: 1.0
References: <mailman.44934.1619368532.1299.openvpn-devel@lists.sourceforge.net>
 <CAHhAHvhNmyRKYuMA8b2cWgL9MvRbo62QPVh34AZLOyVKfcQ9Jw@...278...>
 <20210425172608.GY976@...1296...>
In-Reply-To: <20210425172608.GY976@...1296...>
From: Christian Nilsson <nikize+ovpn@...277...>
Date: Sun, 25 Apr 2021 20:06:27 +0200
Message-ID: <CAHhAHvhQmvtJvY0CBqCp_viU1wckZ61BQ5kEaHki8Mvy-nPJjQ@...278...>
Subject: Re: [Openvpn-devel] Windows openvpnserv2 default reg values instead
 of crash
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: Christian Nilsson <nikize+ovpn@...277...>, openvpn-devel@lists.sourceforge.net

On Sun, 25 Apr 2021 at 19:26, Gert Doering <gert@...1296...> wrote:
>
> Hi,
>
> On Sun, Apr 25, 2021 at 06:44:34PM +0200, Christian Nilsson wrote:
> > I have been wondering if there is any particular reason that
> > crashes in openvpnserv2 should be preferred over
> > having default values if missing from the registry?
>
> openvpnserv2 should never *crash*.
>
> "End itself with an error message" (which is not a "crash") is debatable
> for default values that leave no reasonable default fallback - but
> generally, if it makes sense to default to something, this is a good
> strategy.
>
> So, please send patches :-) (using "git send-email" to stop your mail
> client from messing up tabs etc)
>
> gert
>

Indeed debatable, hmm, but to be clear and avoid misunderstandings;
"Exception occured during OpenVPN service start: " ..
and rethrown exception that is not catched, so I still actually do
think that crash is the correct term here.
This is with no registry values at all, that is
"HKLM\Software\OpenVPN" not existing.

Starting the "git send-email" work, it has been some time since last
time I did that ;-)
Thanks!

/Christian

