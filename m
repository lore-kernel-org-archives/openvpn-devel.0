References: <1467430368-25437-1-git-send-email-selva.nair@...277...>
	<ab01dda4-e7fe-2c9b-c41f-26c7f8f92cd5@...1227...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <94cf2582-6f60-4b3f-0675-c362f2d91238@...1227...>
Date: Sat, 2 Jul 2016 17:32:59 +0200
MIME-Version: 1.0
In-Reply-To: <ab01dda4-e7fe-2c9b-c41f-26c7f8f92cd5@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Exponentially backoff on repeated
 connect retries
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>, openvpn-devel@lists.sourceforge.net


> And why sighup? Shouldn't just limiting sec be enought. SIGHUP has many
> side effects. I don't think we should trigger these for connection time.
> 
> 
> With default setting this results in a SIGHUP after some hours and also
> the last intervals with 5120s are too big for default settings. I would
> aim for something lower like five or ten minutes.

I think a bit about that and I think a good way to specify exponential
back is something like

connect-retry 5 1800, which would mean "scale back up to 1800s" and
maybe default that option to connect-retry 5 300. That also allows
specifying larger connect-retry values without backoff. E.g.
connect-retry 60 60

Arne


