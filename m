Message-ID: <4FAD9053.90006@...1227...>
Date: Sat, 12 May 2012 00:18:59 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <CAOazyz35bB=q1hpdzjj_aHZ7K_0koT8pcw0csham2AOwMqGrfg@...278...>
	<4FAAF945.8070005@...1227...>
	<CAOazyz12Rw0kOSS+siU7tLP4eXO5XkhexjVLn+uC97s4K1Z8EQ@...278...>
	<4FAAFCB4.8040606@...1227...>
	<CAOazyz2wP2ms7HC31LPp3VzFRBu+S3zURZm1ozz0MzjmhQv07g@...278...>
	<4FAB0556.50903@...1227...>
	<CAOazyz2pdJysuaEhoDL8O=S=CdEfW8XCuB6n8YrnKjOBqstTPA@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8A98@...1436...>
	<CAOazyz0Qb8xa-FUqQcMDX=w+=Vb3J8sQ2R8GAxNtfWxT-4DNkw@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8AB9@...1436...>
	<20120511185641.GZ1359@...1296...>
	<4FAD8A16.6020303@...1400...>
	<CAOazyz1dkfwNsAzSF4OXcoMyYezdiJAzH+RMUiqVrAYi7e-ftg@...278...>
	<CAOazyz0NUJvpq=Kt6Pq_gi77-+W4-4aCv9Ox9i+ao70a9CPZoQ@...278...>
In-Reply-To: <CAOazyz0NUJvpq=Kt6Pq_gi77-+W4-4aCv9Ox9i+ao70a9CPZoQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Openvpn for Android 4.0 Changeset
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

>> I would like you to try to do so using libtool...
>>
>> Just replace:
>> ---
>> sbin_PROGRAMS = openvpn
>> openvpn_SOURCES = ....
>> ---
>> with:
>> ---
>> lib_LTLIBRARIES = openvpn.la
>> openvpn_la_SOURCES = ...
>> openvpn_la_LDFLAGS = \
>>    -module -shared -avoid-version -no-undefined
>> ---
>>
>> And add -Dmain=openvpn_main to AM_CFLAGS.
>>
>> Alon.
> You should also change:
> ---
> openvpn_LDADD = ...
> ---
> to:
> ---
> openvpn_la_LDADD = ...
> ---
I can try this sometime later but for the moment I happy with building
the openvpn with the android ndk build system as there a other things
that I prefer to tweaking the build system.

Arne

