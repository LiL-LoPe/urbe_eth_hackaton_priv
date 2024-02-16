import Link from 'next/link';
import RulesButton from './RulesButton'
import SettingButton from './SettingButton';

export default function CommonLayout({ titleText, imageComponent, mainText, buttonCTA, nextPage }) {
  

  return (
    <main className='box flex flex-col items-center align-center justify-evenly w-100 h-screen bg-white px-1.5 py-2 '>
      <div className='header bg-red-500 flex flex-row justify-between items-center w-[96vw] h-[15vh] px-1.5'>
        <div className='flex items-start'>
          <p className='Title'>
            title{titleText}
          </p>
        </div>
        <div className='buttonContainer flex flex-row items-end'>
          <SettingButton />
          <RulesButton />
        </div>
      </div>

      <div className='imagine bg-green-500 w-[96vw] h-[50vh]'>
        {imageComponent}
      </div>

      <div className='text bg-cyan-500 w-[96vw] h-[20vh]'>
        <p className='textStyle w-100'>
          {mainText}
        </p>
      </div>

      <div className='next bg-yellow-500 flex items-center justify-center w-[33vw] h-[10vh]'>
        <Link href={nextPage} passHref>
          <button> {buttonCTA} </button>
        </Link>
      </div>
    </main>
  );
}
