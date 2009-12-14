Message-ID: <4B2634F2.6020405@...515...>
Date: Mon, 14 Dec 2009 14:52:02 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1260552743.31755.0@...1207...>
	<4B22D2C8.5020703@...41...>	<jwv8wd8g722.fsf-monnier+inbox@...1269...>
	<4B23808D.40907@...515...> <4B2407CE.6070301@...1114...>
In-Reply-To: <4B2407CE.6070301@...1114...>
Subject: Re: [Openvpn-devel] OpenVPN project organization
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

David Sommerseth ha scritto:
> On 12/12/09 12:37, Samuli Sepp=E4nen wrote:
> > Now, if we want to maintain stability, we need some way to test the
> > patches. Automated tests could be used in many cases but building the
> > test cases takes time. In addition I don't think automated tests catch
> > nearly all problems, so manual testing is required. I'm not a specialist
> > in VCS systems but I guess a distributed VCS could help in this. What
> > are your thoughts on the testing procedures/tools? Fedora's Beaker suite
> > was mentioned earlier and it sounds interesting.
>
> Let's first give a little introduction of Beaker, so that nobody
> believes it is something exceptionally which solves all the problems.
>
> First of all Beaker is being built up now, it is quite a big project
> consisting of a lot of modules which will communicate together.  I'm not
> sure how far things are in the overall project, but I'll give a little
> intro here about the concept.  Otherwise, beware that crucial modules of
> Beaker might not be ready yet.
>
> A Beaker installation is a big installation.  It is aimed at
> automatically testing software on a broad variety of distributions and
> provide a report of how that test ran.  And you will most probably need
> quite some hardware to get this up and running.
>
> First, Beaker have an inventory module.  Here hosts are registered into
> a database with information about hardware and supported OS and
> distributions.  Then there is a scheduler, which receives requests for
> running particular tests (aka jobs).  The job scheduler then uses the
> inventory to pick out the best suited boxes which are available to run
> the test(s) on.  The inventory is then instructed by the job scheduler
> to do a scratch installation of an assigned OS/distribution.  As a part
> of this OS installation, it will install the defined test scripts on the
> box, run all the tests, collect the results and release the box back to
> the inventory again.
>
> I know the inventory part is pretty much up'n'running, and I believe the
> job scheduler is getting more and more ready.  (It's a while since I
> checked that status) ... so this needs to be checked out.  But as you
> see, some hardware is needed, even though I believe Beaker do (or at
> least will in the future) support virtual hosts as well.  Then the test
> script given to the job scheduler will define who each of the virtual
> hosts will be installed as well.
>
> The good thing about the Beaker framework is that you usually just need
> to install a few packages on your own local box to develop and run the
> test scripts locally.  When the script is ready, it's packaged and sent
> to the tests repository in Beaker.  So it is also possible to run Beaker
> in a very small scale for test development.
>
> You can also browse the test repository via web, and ask for certain
> tests to be run.  The test script defines which packages is needed to
> run the test, and the software being tested needs to be put into a
> special repository, where the script will download and install the
> package, as a part of the test run.
>
> There's also features like multi-host tests, where more hosts are
> involved to run one single test, to test communication between hosts,
> etc.  So this is the direction Beaker is headed.
>
>
> So, back to the topic ... some of these things might already have been
> thought of by the QA team and might even be implemented.  But as I don't
> know how the OpenVPN team does the QA work, I'll share my thoughts here
> ... how I see the "perfect" world :)
>
> Anyhow, you can use such an infrastructure as Beaker to test patches, as
> you vaguely indicated, Samuli.  But Beaker is usually much more suitable
> for testing an already compiled and packaged piece of software before
> shipment.  But of course, it's all scripts, and it can also download
> source code and compile it too.  But I'm not sure how well it will
> perform under these conditions, it might be better with another approach.
>
> However, I would recommend a setup which only a few of the developers
> James will cooperate closely with, including James, will have access to.
>  This setup will do a build of the source code at a given commit, and
> run a standard test suite, aimed at the first stage of the development
> cycle.  This should test for compilation issues (including warnings) and
> report them to the developers.  It should run openvpn in a few different
> modes, with different options to test generic functionality.  It might
> support different test modes, so that the test script will take between
> 5 minutes and 30 minutes, it might even be a few different tests with
> different run times.  This is only aimed at giving a quick indication on
> how well the code is running.
>
> Then when much more commits have been collected, a preliminary package
> can be compiled and sent to a Beaker setup.  The tests here can be much
> more comprehensive, and ideally should test all options and
> configuration modes of OpenVPN.  One test should also be a performance
> tests, which reports the results to a database for tracking the
> performance.  That way, you'll be able to pin-point regressions over
> time.  These Beaker tests may take many hours to run.  But with the
> tracking, you'll get a good overview over what fails and what works, and
> how well it works.
>
> Even though it should be a restricted access to the job scheduler for
> the tests, the reports from it should be available to the community.
> This way developers in the community can follow how the testing is done
> and give feedback if something is wrong with the tests or OpenVPN.  In
> addition, if the test scripts are available for the community, it can
> help out improving and providing new test scripts.  With such an open
> approach, the community will also be involved in the QA work.
>
>
> But I do realise, such a setup is not too easy to acquire.  It requires
> hardware, and a lot of work to come this far.  But I do believe this is
> one (of many) reasonable ways to automate tests and to make sure OpenVPN
> will continue to stay as a stable product.  And in the long run, it
> might help reducing the workload key-persons in the OpenVPN team may have.
>
>
> That's probably enough thoughts for today :)
>
>
> kind regards,
>
> David Sommerseth
I can't see any reason why the test scripts should be secret. So better
have them in the open. Do you think it'd be possible to have a
distributed network of hosts in the inventory? I'm sure there are tons
of people with extra server resources who could contribute by providing
test hosts. Or is the technology dependent on hosts being in the same
physical LAN? If not, we could use, say, IPSec to connect the boxes
safely together (just kidding :)... OpenVPN makes more sense in our
context).

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc




