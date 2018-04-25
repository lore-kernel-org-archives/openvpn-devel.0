MIME-Version: 1.0
In-Reply-To: <20180424221636.257dd814@...1799...>
References: <20180423092813.24844-1-list@...1798...>
 <20180424083801.GB24895@...2161...>
 <20180424120337.0fab107d@...1799...> <20180424130817.GA20143@...2161...>
 <a0da03f3-a1bb-6d2b-bdb5-500db52c5dc1@...2181...>
 <20180424221636.257dd814@...1799...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 25 Apr 2018 11:36:48 -0400
Message-ID: <CAKuzo_gzEdJCYQCQ8k=t0kkPv2Jabb5ZCNgOqM1fYjV8+SuafA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] systemd: run openvpn with dedicated
 user
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
To: Christian Hesse <list@...1798...>
Cc: Antonio Quartulli <a@...2181...>, OpenVPN Development <openvpn-devel@lists.sourceforge.net>

Hi,

On Tue, Apr 24, 2018 at 4:16 PM, Christian Hesse <list@...1798...> wrote:
> Antonio Quartulli <a@...2181...> on Tue, 2018/04/24 23:08:
>> OTOH I understand that there are people that don't care about having a
>> working tunnel reconfiguration and are fine with starting openvpn as
>> root (and then dropping privileges).
>>
>> For these people, adding the above capabilities results in giving the
>> openvpn process more power than before.
>>
>> Maybe users willing to adopt this stricter behaviour should have a knob
>> somewhere that will enable the usual
>> run-as-root-and-then-drop-priv-with-no-caps?
>
> NAK. :-p
>
> I think the solution for this dilemma is pretty easy: I should strip the part
> from my patch that disables user switching when started from systemd. We can
> start as user "openvpn" any way - as long as the process has capabilities
> CAP_SETGID and CAP_SETUID it still can switch user context and drop
> privileges

I'm not yet up to speed with capabilities in recent versions of linux,
but some of the proposed ideas look unsafe to me. In particular:

Be careful setting CAP_SETUID on the file without code changes. Once
that is set, starting as root and dropping privileges is not the same as
starting  as non-root and dropping privileges. In the former case all
capabilities will get cleared (which is good) but not so in the latter case.
The process can elevate back to root in the second case which is bad.
We'll need to add some code to clear all caps before the setuid() call
to do this safely.

Also, if the server is using pam for user-auth, the forked copy needs to run
as root which is currently handled by forking before the setuid call.  Need to
consider how that will work with capabilities without handing out cap_setuid
to all.

As Gert said, looks like we are jumping the gun here. First thoroughly  test
and evaluate the nuances of the use of capabilities in context before
deciding on how to make use of it.

Selva

