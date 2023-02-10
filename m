MIME-Version: 1.0
References: <20230209142248.455120-1-arne@...1227...>
 <CAGyAFMUP-uCrCbQB2u6dOX-MczORL1nmyo9AS5scmTtws6d0Xg@...278...>
 <9b7d0e7b-912d-3daf-db02-8fc99d4f2a43@...1227...>
In-Reply-To: <9b7d0e7b-912d-3daf-db02-8fc99d4f2a43@...1227...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 10 Feb 2023 11:02:19 +0200
Message-ID: <CAGyAFMWQbsMbEZw=SoG9RXrN_FFDWS5nSKyX6UKB=dVhphqe0Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Add 'allow-compression stub-only
 and refuse framing with 'allow-compression no'
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

> We can certainly add logic that will make the
> client abort in this cases but that should affect all the other options
> that are being pushed that the client refuses.

At least for compression we know for sure that the tunnel will be broken,
doesn't it warrant any special case? At least clear log message "you connection
will be broken for sure, but we haven't added logic to not to
establish it at all just yet"

Moreover, with this patch broken VPN providers become even more broken - before
one could add "disable-dco" and have a working tunnel with compression framing.
Right now the behavior is consistently broken with/without dco - which
is expected,
but do we really want to add broken cases?

-- 
-Lev

